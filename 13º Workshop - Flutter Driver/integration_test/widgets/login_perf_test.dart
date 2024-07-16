import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:guildmate/features/features.dart';
import 'package:guildmate/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';

import '../test_helper.dart';

class MockLoginRepository extends Mock implements LoginRepository {
  @override
  Future<Either<Failure, Unit>> login(UserCredential credential) =>
      Future.value(const Right(unit));

  @override
  Future<Either<Failure, Unit>> signInWithGoogle();

  @override
  Future<Either<Failure, Unit>> signInWithTwitter();
}

class MockLoginNavigationService extends Mock
    implements LoginNavigationService {
  @override
  void toForgotPassword();

  @override
  void toHome() => NavigationService().navigateToRoute("/home");

  @override
  void toCreateAccount();
}

class MockHomeNavigationService extends Mock implements HomeNavigationService {
  @override
  void toRegisterProject();
}

void loginTest(IntegrationTestWidgetsFlutterBinding binding) {
  late final SignInWithEmailAndPasswordUseCase signInWithEmail;
  late final SignInWithGoogleUseCase signInWithGoogle;
  late final SignInWithTwitterUseCase signInWithTwitter;
  late final LoginNavigationService navigation;
  late final LoginRepository repository;

  setUp(() {
    repository = MockLoginRepository();
    signInWithEmail = SignInWithEmailAndPasswordUseCase(repository: repository);
    signInWithGoogle = SignInWithGoogleUseCase(repository: repository);
    signInWithTwitter = SignInWithTwitterUseCase(repository: repository);
    navigation = MockLoginNavigationService();
    GetIt.instance.registerFactory(() => LoginBloc(
          signInWithEmail: signInWithEmail,
          signInWithGoogle: signInWithGoogle,
          signInWithTwitter: signInWithTwitter,
          navigate: navigation,
        ));

    GetIt.instance.registerFactory(() => HomeBloc(
          homeNavigationService: MockHomeNavigationService(),
        ));
  });

  testWidgets('perf tap on the login button', (tester) async {
    TestHelper.tester = tester;
    await TestHelper.pumpApp(const MyApp());

    // Finds the floating action button to tap on.
    final fab = find.byKey(const ValueKey('SIGN_IN_BTN'));
    await TestHelper.tapOnButton(finder: fab);

    expect(find.text('Sign in to your account'), findsOneWidget);
    expect(find.byType(LoginPage), findsOneWidget);

    final login = find.byKey(const ValueKey("LOGIN_BTN"));
    final usernameTextField = find.byKey(const ValueKey("USERNAME"));
    final passwordTextField = find.byKey(const ValueKey("PASSWORD"));

    await binding.traceAction(
      () async {
        await TestHelper.enterDataInTextField(
            finder: usernameTextField, data: "teste@gmail.com");
        await TestHelper.enterDataInTextField(
            finder: passwordTextField, data: "12345678");
        await TestHelper.tapOnButton(finder: login);
      },
      reportKey: 'login_form_timeline',
    );
  });

  testWidgets('tap on the floating action button, verify counter',
      (tester) async {
    TestHelper.tester = tester;
    await TestHelper.pumpApp(const MyApp());

    // Finds the floating action button to tap on.
    final fab = find.byKey(const ValueKey('SIGN_IN_BTN'));
    await TestHelper.tapOnButton(finder: fab);

    expect(find.text('Sign in to your account'), findsOneWidget);
    expect(find.byType(LoginPage), findsOneWidget);

    final login = find.byKey(const ValueKey("LOGIN_BTN"));
    final usernameTextField = find.byKey(const ValueKey("USERNAME"));
    final passwordTextField = find.byKey(const ValueKey("PASSWORD"));

    await TestHelper.enterDataInTextField(
        finder: usernameTextField, data: "teste@gmail.com");
    await TestHelper.enterDataInTextField(
        finder: passwordTextField, data: "12345678");
    await TestHelper.tapOnButton(finder: login);

    expect(find.byType(HomePage), findsOneWidget);
  });
}
