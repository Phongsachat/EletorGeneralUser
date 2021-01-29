import 'package:Eletor/ui/camera/camera_view_model.dart';
import 'package:Eletor/ui/camera/character_icons.dart';
import 'package:Eletor/ui/home/headerApp.dart';
import 'package:Eletor/ui/loading/loading_view_model.dart';
import 'package:Eletor/ui/menu/menu_view.dart';
import 'package:Eletor/utils/connectivity/connection.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/Loading/LoadingSpinkit.dart';
import 'package:Eletor/widgets/button/rounded_button.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:Eletor/widgets/dialog_alert/dialog_alert.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

class CameraSendMission extends StatelessWidget {

  final String username;
  final String imageUrl;

  CameraSendMission({this.username,this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CameraViewModel, ConnectionViewModel>(
        builder: (context, states, vm2, child) {
          return states.loading
              ? onLoad(context)
              : Scaffold(
              body: LoadingOverlay(
                isLoading: context.watch<LoadingViewModel>().isPageLoading,
                progressIndicator: spinkitLoading,
                color: overlayLoadingColor,
                opacity: overlayLoadingOpacity,
                child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff616F38), Color(0xffC1DE70)]),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  HeaderApp(),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.only(
                                                topLeft:
                                                const Radius.circular(8.0),
                                                topRight:
                                                const Radius.circular(8.0),
                                                bottomLeft:
                                                const Radius.circular(8.0),
                                                bottomRight:
                                                const Radius.circular(8.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                Colors.grey.withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 8,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Column(
                                                children: [
                                                  showImageSelected(
                                                      states, context),
                                                  Container(
                                                    child: Container(
                                                      height:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                          1.90,
                                                      child: ListView(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              locationAndDatetime(
                                                                  states,
                                                                  context),
                                                              favoriteLocation(
                                                                  states,
                                                                  context),
                                                              datePicker(states,
                                                                  context),
                                                              timePicker(states,
                                                                  context),
                                                              elephantAmount(
                                                                  states,
                                                                  context),
                                                              elephantCharacteristics(
                                                                  states,
                                                                  context),
                                                              reportDetails(
                                                                  states,
                                                                  context),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  submitAndCancel(
                                                      states, context, vm2)
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ));
        });
  }

  Container showImageSelected(states, context) {
    return Container(
      width: double.infinity,
      decoration: new BoxDecoration(
          color: Colors.black,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(8.0),
              topRight: const Radius.circular(8.0),
              bottomLeft: const Radius.circular(8.0),
              bottomRight: const Radius.circular(8.0))),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: (states.imagesFile != null)
                  ? Image.file(states.imagesFile, height: 200)
                  : Container(height: 200))
        ],
      ),
    );
  }

  Container locationAndDatetime(states, context) {
    return Container(
      height: 305,
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(8.0),
            topRight: const Radius.circular(8.0),
            bottomLeft: const Radius.circular(8.0),
            bottomRight: const Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(states.showNameLocation,
                                      style: TextStyle(
                                          fontFamily: primaryFontFamily,
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              new IconButton(
                                icon: new Icon(
                                  Icons.create,
                                  size: 20,
                                ),
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Center(
                                            child: Column(
                                              children: [
                                                Text(StringValue.location,
                                                    style: TextStyle(
                                                        fontFamily:
                                                        primaryFontFamily,
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                Text(states.dateTime,
                                                    style: TextStyle(
                                                        fontFamily:
                                                        primaryFontFamily,
                                                        fontSize: 15,
                                                        color: Colors.grey))
                                              ],
                                            )),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              TextField(
                                                controller:
                                                states.textLocationName,
                                                maxLines: 4,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color(0xffF5F5F5),
                                                  border: InputBorder.none,
                                                  hintText: StringValue
                                                      .pleaseEnterlocation,
                                                  hintStyle: TextStyle(
                                                      fontFamily:
                                                      primaryFontFamily,
                                                      fontSize: 12),
                                                  focusedBorder:
                                                  OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                  ),
                                                  enabledBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text(StringValue.accept,
                                                style: TextStyle(
                                                    fontFamily:
                                                    primaryFontFamily,
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              states.maxLength();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                            child: Text(states.dateTime,
                                style: TextStyle(
                                    fontFamily: primaryFontFamily,
                                    fontSize: 15,
                                    color: Colors.grey))),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(8.0),
                              topRight: const Radius.circular(8.0),
                              bottomLeft: const Radius.circular(8.0),
                              bottomRight: const Radius.circular(8.0))),
                      width: double.infinity,
                      height: 200,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          states.controllerCompleter.complete(controller);
                        },
                        initialCameraPosition: CameraPosition(
                            target: LatLng(states.lat, states.lng), zoom: 15),
                        markers: Set.from(states.myMarker),
                        onTap: (location) {
                          states.pickLocation(context, location);
                        },
                        mapType: MapType.normal,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container favoriteLocation(states, context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        padding: const EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 8,
                offset: Offset(0, 3), // changes position of shadow
              )
            ],
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(8.0),
                topRight: const Radius.circular(8.0),
                bottomLeft: const Radius.circular(8.0),
                bottomRight: const Radius.circular(8.0))),
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(StringValue.favoriteLocationTitle,
                    style: TextStyle(
                        fontFamily: primaryFontFamily,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  child: InkWell(
                    onTap: () {
                      states.selectTime(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(8.0),
                              topRight: const Radius.circular(8.0),
                              bottomLeft: const Radius.circular(8.0),
                              bottomRight: const Radius.circular(8.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: states.favoriteLocationValue,
                              items: [
                                DropdownMenuItem(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.7,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                          Text(
                                              StringValue
                                                  .favoriteLocationValue0,
                                              style: TextStyle(
                                                  fontFamily: primaryFontFamily,
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.7,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                          Text(
                                              StringValue
                                                  .favoriteLocationValue1,
                                              style: TextStyle(
                                                  fontFamily: primaryFontFamily,
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.7,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                          Text(
                                              StringValue
                                                  .favoriteLocationValue2,
                                              style: TextStyle(
                                                  fontFamily: primaryFontFamily,
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  value: 3,
                                ),
                                DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            1.7,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                            ),
                                            Text(
                                                StringValue
                                                    .favoriteLocationValue3,
                                                style: TextStyle(
                                                    fontFamily:
                                                    primaryFontFamily,
                                                    fontSize: 15,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    value: 4),
                                DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            1.7,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                            ),
                                            Text(
                                                StringValue
                                                    .favoriteLocationValue4,
                                                style: TextStyle(
                                                    fontFamily:
                                                    primaryFontFamily,
                                                    fontSize: 15,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    value: 5),
                                DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            1.7,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.close,
                                              color: Colors.black,
                                            ),
                                            Text(
                                                StringValue
                                                    .notUseFavoriteLocation,
                                                style: TextStyle(
                                                    fontFamily:
                                                    primaryFontFamily,
                                                    fontSize: 15,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    value: 6)
                              ],
                              onChanged: (value) {
                                states.favoriteLocation(value, context);
                              }),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }

  Container datePicker(states, context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        padding: const EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 8,
                offset: Offset(0, 3), // changes position of shadow
              )
            ],
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(8.0),
                topRight: const Radius.circular(8.0),
                bottomLeft: const Radius.circular(8.0),
                bottomRight: const Radius.circular(8.0))),
        child: Container(
          child: Row(children: [
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(StringValue.date,
                    style: TextStyle(
                        fontFamily: primaryFontFamily,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Flexible(
              child: Row(
                children: <Widget>[
                  Container(
                    child: InkWell(
                      onTap: () {
                        states.selectDate(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.6,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xffF5F5F5),
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(8.0),
                                topRight: const Radius.circular(8.0),
                                bottomLeft: const Radius.circular(8.0),
                                bottomRight: const Radius.circular(8.0))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                          onSaved: (String val1) {
                            print("selectedDate : " + states.selectedDate);
                            states.selectedDate = val1;
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: states.dateController,
                          decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              // labelText: 'Time',
                              contentPadding: EdgeInsets.all(5)),
                        ),
                      ),
                    ),

                    /* child:InkWell(
                      onTap: () {
                        states.selectTime(context);
                      },*/
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Container timePicker(states, context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        padding: const EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 8,
                offset: Offset(0, 3), // changes position of shadow
              )
            ],
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(8.0),
                topRight: const Radius.circular(8.0),
                bottomLeft: const Radius.circular(8.0),
                bottomRight: const Radius.circular(8.0))),
        child: Container(
          child: Row(children: [
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(StringValue.time,
                    style: TextStyle(
                        fontFamily: primaryFontFamily,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Flexible(
              child: Row(
                children: <Widget>[
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          showPicker(
                            context: context,
                            value: states.selectedTime,
                            onChange: states.selectTime,
                            minuteInterval: MinuteInterval.FIVE,
                            disableHour: false,
                            disableMinute: false,
                            minMinute: 0,
                            maxMinute: 59,
                            is24HrFormat: true,
                            onChangeDateTime: (DateTime dateTime) {
                              states.selectTime(dateTime);
                              print(dateTime);
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.6,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xffF5F5F5),
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(8.0),
                                topRight: const Radius.circular(8.0),
                                bottomLeft: const Radius.circular(8.0),
                                bottomRight: const Radius.circular(8.0))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                          onSaved: (String val) {
                            states.selectedTime = val;
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: states.timeController,
                          decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              // labelText: 'Time',
                              contentPadding: EdgeInsets.all(5)),
                        ),
                      ),
                    ),

                    /* child:InkWell(
                      onTap: () {
                        states.selectTime(context);
                      },*/
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Container elephantAmount(states, context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        padding: const EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 8,
                offset: Offset(0, 3), // changes position of shadow
              )
            ],
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(8.0),
                topRight: const Radius.circular(8.0),
                bottomLeft: const Radius.circular(8.0),
                bottomRight: const Radius.circular(8.0))),
        child: Container(
            height: 50,
            child: Row(children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width/2.6,
                  child: Text(StringValue.elephantAmount,
                      style: TextStyle(
                          fontFamily: primaryFontFamily,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                width: 100,
                child: TextField(
                  controller: states.textElephantAmount,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF5F5F5),
                    border: InputBorder.none,
                    hintText: StringValue.pleaseEnterElephantAmount,
                    hintStyle:
                    TextStyle(fontFamily: primaryFontFamily, fontSize: 12),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(StringValue.elephantUnit,
                    style: TextStyle(
                        fontFamily: primaryFontFamily,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ])
          /*child: Row(children: [
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(StringValue.elephantAmount,
                    style: TextStyle(
                        fontFamily: primaryFontFamily,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Flexible(
                child: TextField(
              controller: states.textElephantAmount,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(4),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffF5F5F5),
                border: InputBorder.none,
                hintText: StringValue.pleaseEnterElephantAmount,
                hintStyle:
                    TextStyle(fontFamily: primaryFontFamily, fontSize: 12),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ))
          ]),*/
        ));
  }

  Container elephantCharacteristics(states, context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 8,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(8.0),
              topRight: const Radius.circular(8.0),
              bottomLeft: const Radius.circular(8.0),
              bottomRight: const Radius.circular(8.0))),
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringValue.elephantCharacter,
              style: TextStyle(
                  fontFamily: primaryFontFamily,
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF5F5F5),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: ToggleButtons(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(Character.bx_restaurant,
                              size: MediaQuery.of(context).size.height / 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(Character.road_variant,
                              size: MediaQuery.of(context).size.height / 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(Character.bx_angry,
                              size: MediaQuery.of(context).size.height / 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(Character.bxs_car_crash,
                              size: MediaQuery.of(context).size.height / 25),
                        ),
                      ],
                      onPressed: (int index) {
                        states.isSelectedValue(index);
                      },
                      borderWidth: 2,
                      borderColor: Color(0xff616F38),
                      selectedBorderColor: Color(0xff616F38),
                      color: Color(0xff616F38),
                      selectedColor: Colors.white,
                      fillColor: Color(0xff616F38),
                      borderRadius: BorderRadius.circular(30),
                      isSelected: states.isSelected,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container reportDetails(states, context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 8,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(8.0),
              topRight: const Radius.circular(8.0),
              bottomLeft: const Radius.circular(8.0),
              bottomRight: const Radius.circular(8.0))),
      child: Column(
        children: [
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(StringValue.reportDetails,
                  style: TextStyle(
                      fontFamily: primaryFontFamily,
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            child: TextField(
              controller: states.textNote,
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(400)
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffF5F5F5),
                border: InputBorder.none,
                hintText: StringValue.pleaseEnterDetails,
                hintStyle:
                TextStyle(fontFamily: primaryFontFamily, fontSize: 12),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container submitAndCancel(states, context, vm2) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child: RoundedButton(
                    onTap: () {
                      states.clearData();
                      // context.read<MenuViewModel>().changePage(0);
                      Get.offAll(MenuView(username: username,imageUrl: imageUrl));
                    },
                    color: btnCancel,
                    text: StringValue.cancel,
                    width: 120,
                    padding: const EdgeInsets.all(2),
                    radius: 8,
                    height: 40,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child: RoundedButton(
                    onTap: () async {
                      // isConnected!!!
                      if (vm2.isConnected==true) {
                        Provider.of<LoadingViewModel>(context, listen: false)
                            .showLoading();
                        await states.submitValue();
                        if (states.valueCheck == false) {
                          Provider.of<LoadingViewModel>(context, listen: false)
                              .dismissLoading();
                          // valueNullAlert(states, context);
                          DialogAlert().dialogNotify(
                              context,
                              StringValue.errorValueNull,
                              StringValue.errorValueNullDetails,
                              Colors.red);
                        } else {
                          Provider.of<LoadingViewModel>(context, listen: false)
                              .dismissLoading();
                          await DialogAlert().dialogNotify(
                              context,
                              StringValue.sendReportCompleteTitle,
                              StringValue.sendReportCompleteContent,
                              Colors.green);
                          states.clearData();
                          Get.offAll(MenuView());
                        }
                      } else {
                        reportDisconnected(context);
                      }
                    },
                    color: btnAccept,
                    text: StringValue.sendMission,
                    width: 120,
                    padding: const EdgeInsets.all(2),
                    radius: 8,
                    height: 40,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  //
  // valueNullAlert(states, context) {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false,
  //     // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Center(
  //             child: Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
  //               child: Text(StringValue.errorValueNull,
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                       fontFamily: primaryFontFamily,
  //                       fontSize: 15,
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold)),
  //             ),
  //             Text(StringValue.errorValueNullDetails,
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                     fontFamily: primaryFontFamily,
  //                     fontSize: 15,
  //                     color: Colors.grey))
  //           ],
  //         )),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text(StringValue.assent,
  //                 style: TextStyle(
  //                     fontFamily: primaryFontFamily,
  //                     fontSize: 15,
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.bold)),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               states.maxLength();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  onLoad(context) {
    return Consumer<LoadingViewModel>(builder: (context, states, child) {
      return Scaffold(
          body: LoadingOverlay(
            isLoading: states.isPageLoading,
            progressIndicator: spinkitLoading,
            color: overlayLoadingColor,
            opacity: overlayLoadingOpacity,
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff616F38), Color(0xffC1DE70)]),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 150,
                        )
                      ],
                    )),
              ],
            ),
          ));
    });
  }

  reportDisconnected(BuildContext context) {
    NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text(StringValue.reportDisconnectedTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: primaryFontFamily,
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.bold)),
      content: Text(StringValue.reportDisconnectedDetails,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: primaryFontFamily,
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.normal)),
      actions: [
        FlatButton(
            child: Text(StringValue.accept,
                style: TextStyle(
                    fontFamily: primaryFontFamily,
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.grey[200], width: 1, style: BorderStyle.solid),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<LoadingViewModel>(context, listen: false)
                  .dismissLoading();
            }),
      ],
    ).show(context);
  }
}
