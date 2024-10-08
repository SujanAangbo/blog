import 'package:blog/core/common/cubits/user_cubit.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog/features/auth/domain/usecases/current_user.dart';
import 'package:blog/features/auth/domain/usecases/user_login.dart';
import 'package:blog/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/blog/data/data_source/blog_local_data_source.dart';
import 'package:blog/features/blog/data/data_source/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog/features/blog/domain/usecases/get_blogs.dart';
import 'package:blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/secrets/supabase_secret.dart';

part 'init_dependencies.main.dart';
