import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/profile/model/user_info/user_updated_info.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../../core/remote_urls.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';
import '../../authentication/widgets/sign_up_form.dart';
import '../controllers/country_state_by_id/country_state_by_id_cubit.dart';
import '../controllers/profile_edit/profile_edit_cubit.dart';
import '../controllers/updated_info/updated_info_cubit.dart';
import '../model/city_model.dart';
import '../model/country_model.dart';
import '../model/country_state_model.dart';

class ProfileEditForm extends StatefulWidget {
  const ProfileEditForm({
    Key? key,
    required this.userData,
  }) : super(key: key);
  final UserProfileInfo userData;

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  CountryModel? _currentCountry;
  CountryStateModel? _countryState;
  CityModel? _cityModel;
  List<CountryModel> countries = [];
  List<CountryStateModel> stateList = [];
  List<CityModel> cityList = [];

  // UserUpdatedInfo? updatedInfo;

  @override
  void initState() {
    super.initState();
    loadRegion();
  }

  loadRegion() {
    // context.read<CountryStateByIdCubit>().countryList = context.read<CountryStateByIdCubit>().countryList;
    countries = context.read<CountryStateByIdCubit>().countryList;
    context.read<CountryStateByIdCubit>().stateList =
        widget.userData.stateModel;
    context.read<CountryStateByIdCubit>().cities = widget.userData.cityModel;
    log(countries.toString(), name: "CountryList");

    // log(stateList.toString(), name: "Statelist");
    // log(cityList.toString(), name: "citylist");
    log(widget.userData.stateModel.toString(), name: "StateList");
    log(widget.userData.cityModel.toString(), name: "cityList");

    //preload the information in states
    context
        .read<ProfileEditCubit>()
        .changeAddress(widget.userData.updateUserInfo.address);
    context
        .read<ProfileEditCubit>()
        .changeCountry("${widget.userData.updateUserInfo.countryId}");
    context
        .read<ProfileEditCubit>()
        .changeState("${widget.userData.updateUserInfo.stateId}");
    context
        .read<ProfileEditCubit>()
        .changeCity("${widget.userData.updateUserInfo.cityId}");
    //

    // _countryState = null;
    _countryState = context
        .read<UserProfileInfoCubit>()
        .defaultState(widget.userData.updateUserInfo.stateId.toString());

    if (_countryState != null) {
      log(_countryState.toString(), name: "_stateModel");

      _cityModel = context
          .read<UserProfileInfoCubit>()
          .defaultCity(widget.userData.updateUserInfo.cityId.toString());
      log(_cityModel.toString(), name: "_cityModel");
    }

    for (var element in widget.userData.countryModel) {
      if (element.id == widget.userData.updateUserInfo.countryId) {
        _currentCountry = element;

        break;
      }
    }

    // for (var element in widget.userData.stateModel.toSet().toList()) {
    //   if (element.id.toString() == widget.userData.updateUserInfo.countryId) {
    //     _countryState = element;
    //     print("_country $_currentCountry");
    //     break;
    //   }
    // }
    // for (var element in widget.userData.cityModel) {
    //   if (element.id.toString() == widget.userData.updateUserInfo.countryId) {
    //     _cityModel = element;
    //     print("_country $_currentCountry");
    //     break;
    //   }
    // }
  }

  void _loadState(CountryModel countryModel) {
    _currentCountry = countryModel;
    _countryState = null;
    _cityModel = null;

    final stateLoadIdCountryId =
        context.read<CountryStateByIdCubit>().stateLoadIdCountryId;

    stateLoadIdCountryId(countryModel.id.toString());
  }

  void _loadCity(CountryStateModel countryStateModel) {
    _countryState = countryStateModel;
    _cityModel = null;

    final cityLoadIdStateId =
        context.read<CountryStateByIdCubit>().cityLoadIdStateId;

    cityLoadIdStateId(countryStateModel.id.toString());
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final zipCodeController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profileEdBlc = context.read<ProfileEditCubit>();

    return BlocBuilder<CountryStateByIdCubit, CountryStateByIdState>(
      builder: (context, state) {
        if (state is CountryStateByIdStateLoadied) {
          _countryState = context
              .read<CountryStateByIdCubit>()
              .filterState(widget.userData.updateUserInfo.stateId.toString());

          if (_countryState != null) {
            log(_countryState.toString(), name: "_stateModel");

            _cityModel = context
                .read<CountryStateByIdCubit>()
                .filterCity(widget.userData.updateUserInfo.cityId.toString());
            log(_cityModel.toString(), name: "_cityModel");
          }
        }
        // return BlocBuilder<UserProfileInfoCubit, UserProfilenfoState>(
        //   builder: (context, s) {
        //     if (s is UpdatedLoaded) {
        //       _countryState = context
        //           .read<UserProfileInfoCubit>()
        //           .defaultState(widget.userData.updateUserInfo.stateId ?? '');
        //
        //       if (_countryState != null) {
        //         log(_countryState.toString(), name: "_stateModel");
        //
        //         _cityModel = context
        //             .read<UserProfileInfoCubit>()
        //             .defaultCity(widget.userData.updateUserInfo.cityId ?? '');
        //         log(_cityModel.toString(), name: "_cityModel");
        //       }
        //     }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImage(),
            Text(
              widget.userData.updateUserInfo.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            BlocBuilder<ProfileEditCubit, ProfileEditStateModel>(
              buildWhen: (p, c) => true,
              builder: (context, state) {
                final edit = state.stateStatus;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: widget.userData.updateUserInfo.name,
                      onChanged: profileEdBlc.changeName,
                      decoration: InputDecoration(
                          hintText: Language.name.capitalizeByWord()),
                    ),
                    if (edit is ProfileEditFormValidState) ...[
                      if (edit.errors.name.isNotEmpty)
                        ErrorText(text: edit.errors.name.first),
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<ProfileEditCubit, ProfileEditStateModel>(
              builder: (context, state) {
                final edit = state.stateStatus;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      onChanged: profileEdBlc.changePhone,
                      initialValue: widget.userData.updateUserInfo.phone,
                      decoration: InputDecoration(
                        hintText: Language.phoneNumber.capitalizeByWord(),
                        prefixIcon: CountryCodePicker(
                          padding: const EdgeInsets.only(bottom: 8),
                          onChanged: (country) {
                            profileEdBlc
                                .changePhoneCode(country.dialCode ?? '');
                          },
                          flagWidth: 35,
                          initialSelection: 'BD',
                          favorite: const ['+88', 'BD'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                      ),
                    ),
                    if (edit is ProfileEditFormValidState) ...[
                      if (edit.errors.phone.isNotEmpty)
                        ErrorText(text: edit.errors.phone.first),
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<ProfileEditCubit, ProfileEditStateModel>(
              builder: (context, state) {
                final edit = state.stateStatus;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _countryField(),
                    if (edit is ProfileEditFormValidState) ...[
                      if (edit.errors.country.isNotEmpty)
                        ErrorText(text: edit.errors.country.first),
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<ProfileEditCubit, ProfileEditStateModel>(
              builder: (context, state) {
                final edit = state.stateStatus;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    stateField(),
                    if (edit is ProfileEditFormValidState) ...[
                      if (edit.errors.state.isNotEmpty)
                        ErrorText(text: edit.errors.state.first),
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            cityField(),
            const SizedBox(height: 16),
            // TextFormField(
            //   keyboardType: TextInputType.number,
            //   initialValue: widget.userData.updateUserInfo.zipCode,
            //   onChanged: profileEdBlc.changeZipCode,
            //   validator: (String? v) {
            //     if (v == null || v.isEmpty) return "*Zip Code is Required";
            //     return null;
            //   },
            //   decoration: const InputDecoration(hintText: 'Your zip-code'),
            // ),
            // const SizedBox(height: 16),

            BlocBuilder<ProfileEditCubit, ProfileEditStateModel>(
              builder: (context, state) {
                final edit = state.stateStatus;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      initialValue: widget.userData.updateUserInfo.address,
                      onChanged: profileEdBlc.changeAddress,
                      // validator: (String? v) {
                      //   if (v == null || v.isEmpty)
                      //     return '*Address is Required';
                      //   return null;
                      // },
                      decoration: InputDecoration(
                          hintText: Language.yourAddress.capitalizeByWord()),
                    ),
                    if (edit is ProfileEditFormValidState) ...[
                      if (edit.errors.address.isNotEmpty)
                        ErrorText(text: edit.errors.address.first),
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 20),

            BlocListener<ProfileEditCubit, ProfileEditStateModel>(
              listener: (context, state) {
                if (state.stateStatus is ProfileEditStateLoading) {
                  Utils.loadingDialog(context);
                } else {
                  Utils.closeDialog(context);
                  if (state.stateStatus is ProfileEditStateError) {
                    final e = state.stateStatus as ProfileEditStateError;
                    Utils.errorSnackBar(context, e.message);
                  } else if (state.stateStatus is ProfileEditStateLoaded) {
                    context.read<CountryStateByIdCubit>().countryListLoaded();
                    context.read<UserProfileInfoCubit>().getUserProfileInfo();
                    Navigator.pop(context);
                    Utils.showSnackBar(context, 'Successfully Updated');
                  }
                }
              },
              child: PrimaryButton(
                text: Language.updateProfile.capitalizeByWord(),
                onPressed: () {
                  // if (!context
                  //     .read<ProfileEditCubit>()
                  //     .profileFormKey
                  //     .currentState!
                  //     .validate()) return;
                  Utils.closeKeyBoard(context);
                  context.read<ProfileEditCubit>().submitForm();

                  // print('UPDATED... ${context.read<ProfileEditCubit>().submitForm()}');
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
        //   },
        // );
      },
    );
  }

  Widget _buildImage() {
    return BlocBuilder<ProfileEditCubit, ProfileEditStateModel>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        String profileImage = widget.userData.updateUserInfo.image.isNotEmpty
            ? RemoteUrls.imageUrl(widget.userData.updateUserInfo.image)
            : RemoteUrls.imageUrl(widget.userData.defaultImage!.image);

        profileImage = state.image.isNotEmpty ? state.image : profileImage;

        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff333333).withOpacity(.18),
                blurRadius: 70,
              ),
            ],
          ),
          child: Center(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomImage(
                    path: profileImage,
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                    isFile: state.image.isNotEmpty,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: InkWell(
                    onTap: () async {
                      final imageSourcePath = await Utils.pickSingleImage();
                      context
                          .read<ProfileEditCubit>()
                          .changeImage(imageSourcePath);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Color(0xff18587A),
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _countryField() {
    final addressBl = context.read<CountryStateByIdCubit>();
    return DropdownButtonFormField<CountryModel>(
      value: _currentCountry,
      // hint:  Text(addressBl.countryList[0].name),
      hint: Text(Language.country.capitalizeByWord()),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          // borderSide: BorderSide(width: 1, color: CustomColors.lineColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onTap: () async {
        Utils.closeKeyBoard(context);
      },
      onChanged: (value) {
        if (value == null) return;
        _loadState(value);

        context.read<ProfileEditCubit>().changeCountry(value.id.toString());
      },
      // validator: (value) => value == null ? '*City is Required' : null,
      isDense: true,
      isExpanded: true,
      items: addressBl.countryList.isEmpty
          ? null
          : addressBl.countryList
              .map<DropdownMenuItem<CountryModel>>((CountryModel value) {
              return DropdownMenuItem<CountryModel>(
                  value: value, child: Text(value.name));
            }).toList(),
    );
  }

  Widget stateField() {
    final profileBl = context.read<ProfileEditCubit>();
    final addressBl = context.read<CountryStateByIdCubit>();
    return DropdownButtonFormField<CountryStateModel>(
      value: _countryState,
      hint: Text(Language.state.capitalizeByWord()),
      // hint:  Text(profileBl.state.state),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          // borderSide: BorderSide(width: 1, color: CustomColors.lineColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onTap: () async {
        Utils.closeKeyBoard(context);
      },
      onChanged: (value) {
        if (value == null) return;
        // _cityModel = null;
        _countryState = value;
        _loadCity(value);
        // addressBl.cityStateChangeCityFilter(value);
        profileBl.changeState(value.id.toString());
      },
      // validator: (value) => value == null ? '*State is Required' : null,
      isDense: true,
      isExpanded: true,
      items: addressBl.stateList.isEmpty
          ? null
          : addressBl.stateList.map<DropdownMenuItem<CountryStateModel>>(
              (CountryStateModel value) {
              return DropdownMenuItem<CountryStateModel>(
                  value: value, child: Text(value.name));
            }).toList(),
    );
  }

  Widget cityField() {
    final profileBl = context.read<ProfileEditCubit>();
    final addressBl = context.read<CountryStateByIdCubit>();
    return DropdownButtonFormField<CityModel>(
      value: _cityModel,
      // hint:  Text(profileBl.state.city),
      hint: Text(Language.city.capitalizeByWord()),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onTap: () {
        Utils.closeKeyBoard(context);
      },
      onChanged: (value) {
        _cityModel = value;
        if (value == null) return;
        profileBl.changeCity(value.id.toString());
      },
      // validator: (value) => value == null ? 'field required' : null,
      isDense: true,
      isExpanded: true,
      items: addressBl.cities.isEmpty
          ? null
          : addressBl.cities
              .map<DropdownMenuItem<CityModel>>((CityModel value) {
              return DropdownMenuItem<CityModel>(
                  value: value, child: Text(value.name));
            }).toList(),
    );
  }
}
