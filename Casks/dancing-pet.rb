cask "dancing-pet" do
  version "1.0.2"
  sha256 "c8c75fe22dd8ea169bb5c7e89636aba235ec17ea3f44523642f856532cd07896"

  url "https://github.com/asdeszqsc/dancing-pet/releases/download/v#{version}/DancingPet_#{version}_universal.dmg"
  name "DancingPet"
  desc "Menu-bar desktop pet (Waabi) that walks, climbs the Dock, and dances to audio"
  homepage "https://github.com/asdeszqsc/dancing-pet"

  depends_on macos: :monterey

  app "DancingPet.app"

  # 공증되지 않은 앱이라 Gatekeeper 격리 속성을 제거해 경고 없이 실행되게 함
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/DancingPet.app"]
  end

  caveats <<~EOS
    DancingPet은 Dock 위치 감지를 위해 손쉬운 사용(Accessibility) 권한이 필요합니다.
    최초 실행 후 시스템 설정 → 개인정보 보호 및 보안 → 손쉬운 사용 에서 DancingPet을 허용해 주세요.

    1.0.3 미만 버전에서 업그레이드한 경우, 한 번만 아래를 실행한 뒤
    앱을 재시작하고 권한을 다시 허용해 주세요 (이후 업데이트부터는 유지됩니다):
      tccutil reset Accessibility com.dancingpet.app
  EOS

  zap trash: [
    "~/Library/Application Support/com.dancingpet.app",
    "~/Library/Caches/com.dancingpet.app",
    "~/Library/WebKit/com.dancingpet.app",
    "~/Library/Preferences/com.example.dancingpet.plist",
  ]
end
