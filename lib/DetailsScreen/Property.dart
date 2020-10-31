import 'package:flutter/material.dart';

import '../Utilities/Constants.dart';

class Property extends StatelessWidget {
  final String propertyValue;

  final String propertyHeading;

  Property({@required this.propertyValue,@required this.propertyHeading});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$propertyValue', style: kGreyPropertiesBody),
        Text('$propertyHeading', style: kGreyPropertiesHeading),
      ],
    );
  }
}

class PaddedProperty extends StatelessWidget {
  final String propertyValue;

  final String propertyHeading;

  PaddedProperty({@required this.propertyValue,@required this.propertyHeading,});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Property(propertyValue: propertyValue,propertyHeading: propertyHeading,),
    );
  }
}
