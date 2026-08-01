import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as admob;

typedef OnConsentGatheringCompleteListener = void Function(
    admob.FormError? error);

/// 広告のためのユーザー同意フローの管理。
///
/// Google の User Messaging Platform (UMP) による同意取得（GDPR 等）と、
/// iOS の App Tracking Transparency (ATT) 許可リクエストを扱う。
///
/// UMP と ATT は別物である点に注意:
/// - UMP は AdMob 管理画面で設定したメッセージ（GDPR 同意フォーム等）を出す。
/// - iOS の ATT ダイアログは UMP には含まれないため、
///   [AppTrackingTransparency.requestTrackingAuthorization] で別途表示する。
///
/// 実装は Google 公式の Flutter サンプル (googleads-mobile-flutter) の
/// ConsentManager に準拠し、ATT リクエストを追加している。
/// 公式が推奨する順序は「UMP フォーム → ATT アラート」。
class ConsentManager {
  ConsentManager._internal();

  static final ConsentManager instance = ConsentManager._internal();

  /// 広告をリクエストできる状態かどうかを返す。
  ///
  /// UMP の同意状況に基づいて Mobile Ads SDK が判定する。
  Future<bool> canRequestAds() async {
    return await admob.ConsentInformation.instance.canRequestAds();
  }

  /// プライバシー設定フォームの表示が必要かどうかを返す。
  ///
  /// EU 圏など、ユーザーが後から同意を変更できる導線が必要な場合に true。
  Future<bool> isPrivacyOptionsRequired() async {
    return await admob.ConsentInformation.instance
            .getPrivacyOptionsRequirementStatus() ==
        admob.PrivacyOptionsRequirementStatus.required;
  }

  /// UMP の同意情報を更新し、必要なら同意フォームを表示する。
  /// その後、iOS では ATT の許可ダイアログを表示する。
  ///
  /// この処理はアプリ起動のたびに呼ぶ（UMP が表示要否を判断する）。
  /// 完了時に [onComplete] を呼ぶ。エラーがあれば引数に渡す。
  void gatherConsent(OnConsentGatheringCompleteListener onComplete) {
    final params = admob.ConsentRequestParameters();

    admob.ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        // UMP フォーム（GDPR 同意等）を必要に応じて表示する。
        await admob.ConsentForm.loadAndShowConsentFormIfRequired(
          (final admob.FormError? formError) async {
            // UMP フォームの後に ATT の許可をリクエストする。
            await _requestTrackingAuthorization();
            onComplete(formError);
          },
        );
      },
      (final admob.FormError formError) async {
        // UMP の取得に失敗しても ATT リクエストは試みる。
        await _requestTrackingAuthorization();
        onComplete(formError);
      },
    );
  }

  /// iOS の ATT 許可ダイアログを表示する。
  ///
  /// - まだ許可/拒否が決まっていない (notDetermined) 場合のみ表示する。
  /// - ATT は「1 インストールにつき 1 回」しか表示されない仕様。
  /// - Android では何もしない（プラグイン側で no-op になる）。
  Future<void> _requestTrackingAuthorization() async {
    final status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  /// プライバシー設定フォーム（ユーザーが同意を変更するための画面）を表示する。
  void showPrivacyOptionsForm(
    admob.OnConsentFormDismissedListener onDismissed,
  ) {
    admob.ConsentForm.showPrivacyOptionsForm(onDismissed);
  }
}
