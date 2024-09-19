import 'dart:io';
import 'dart:math';

import 'package:blog/core/common/cubits/user_cubit.dart';
import 'package:blog/core/common/widgets/snackbar.dart';
import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/theme/app_pallet.dart';
import 'package:blog/core/utils/pick_image.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/pages/blog_page.dart';
import 'package:blog/features/blog/presentation/widgets/blog_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBlogPage extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const CreateBlogPage(),
      );

  const CreateBlogPage({super.key});

  @override
  State<CreateBlogPage> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? image;
  List<String> selectedCategory = [];

  String? errorMessage;

  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void createBlog() {
    if (selectedCategory.isEmpty) {
      errorMessage = "Select at least one category";
      setState(() {});
      return;
    }

    if (formKey.currentState!.validate()) {
      String title = titleController.text;
      String description = descriptionController.text;

      print(
        "title: $title, description: $description, selectedCategory: $selectedCategory, image: $image",
      );
      final posterId =
          (context.read<UserCubit>().state as UserLoggedInState).user.id;
      context.read<BlogBloc>().add(
            BlogUploadEvent(
              title: title,
              description: description,
              categories: selectedCategory,
              posterId: posterId,
              image: image,
            ),
          );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: createBlog,
              icon: const Icon(Icons.check),
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogErrorState) {
              showErrorSnackbar(context, state.message);
            } else if (state is BlogSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                BlogPage.route(),
                (route) => route.isFirst,
              );
              showSuccessSnackbar(context, "Blog Uploaded Successfully");
            }
          },
          builder: (context, state) {
            if (state is BlogLoadingState) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      image != null
                          ? GestureDetector(
                              onTap: selectImage,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  image!,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: selectImage,
                              child: Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 30,
                                    ),
                                    Text(
                                      "Select your image",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            'Technology',
                            'Business',
                            'Programming',
                            'Education',
                          ]
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    if (selectedCategory.contains(e)) {
                                      selectedCategory.remove(e);
                                    } else {
                                      selectedCategory.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: categoryChip(
                                    e,
                                    selectedCategory.contains(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      if (errorMessage != null)
                        Text(
                          "    ${errorMessage!}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppPallet.errorColor,
                          ),
                        ),
                      const SizedBox(height: 10),
                      BlogField(
                        controller: titleController,
                        hint: "Blog Title",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Title is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      BlogField(
                        controller: descriptionController,
                        hint: "Blog Description",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Description is required";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget categoryChip(String category, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Chip(
        label: Text(
          category,
          style: const TextStyle(color: Colors.white),
        ),
        color: WidgetStatePropertyAll(isSelected ? Colors.purpleAccent : null),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
    );
  }
}
