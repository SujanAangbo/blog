import 'package:flutter/material.dart';

void showErrorSnackbar(context, message) => ScaffoldMessenger.of(context)
  ..clearSnackBars()
  ..hideCurrentSnackBar()
  ..showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ),
  );

void showSuccessSnackbar(context, message) => ScaffoldMessenger.of(context)
  ..clearSnackBars()
  ..hideCurrentSnackBar()
  ..showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ),
  );
