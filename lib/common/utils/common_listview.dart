import 'package:flutter/material.dart';

Widget buildListView({
  required itemBuilder,
  required item,
  scrollDirection = Axis.horizontal,
}) {
  return ListView.builder(
    itemBuilder: itemBuilder,
    itemCount: item.length,
    scrollDirection: scrollDirection,
  );
}
