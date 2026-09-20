{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
}:
let
  sources = builtins.fromJSON (builtins.readFile ./sources.json);
  inherit (sources) version;
  dist = fetchFromGitHub {
    owner = "caddyserver";
    repo = "dist";
    tag = "v${version}";
    hash = sources.distHash;
  };
in
buildGoModule {
  pname = "caddy";
  inherit version;

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./main.go
      ./go.mod
      ./go.sum
    ];
  };

  inherit (sources) vendorHash;
  subPackages = [ "." ];

  # Match the standard Nixpkgs Caddy build.
  tags = [
    "nobadger"
    "nomysql"
    "nopgx"
  ];
  ldflags = [
    "-s"
    "-w"
    "-X github.com/caddyserver/caddy/v2.CustomVersion=${version}"
  ];

  nativeBuildInputs = [ installShellFiles ];
  postInstall = ''
    install -Dm644 ${dist}/init/caddy.service ${dist}/init/caddy-api.service -t $out/lib/systemd/system
    substituteInPlace $out/lib/systemd/system/caddy.service \
      --replace-fail "/usr/bin/caddy" "$out/bin/caddy"
    substituteInPlace $out/lib/systemd/system/caddy-api.service \
      --replace-fail "/usr/bin/caddy" "$out/bin/caddy"

    $out/bin/caddy manpage --directory manpages
    installManPage manpages/*
    installShellCompletion --cmd caddy \
      --bash <($out/bin/caddy completion bash) \
      --fish <($out/bin/caddy completion fish) \
      --zsh <($out/bin/caddy completion zsh)
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck
    $out/bin/caddy version | awk '$1 == "${version}" { found = 1 } END { exit !found }'
    $out/bin/caddy build-info | awk '$2 == "github.com/caddyserver/caddy/v2" && $3 == "v${version}" { found = 1 } END { exit !found }'
    $out/bin/caddy list-modules | grep -Fx 'dns.providers.cloudflare'
    $out/bin/caddy build-info | awk '$2 == "github.com/caddy-dns/cloudflare" && $3 == "${sources.cloudflareVersion}" { found = 1 } END { exit !found }'
    runHook postInstallCheck
  '';

  meta = {
    description = "Caddy with the Cloudflare DNS module";
    homepage = "https://caddyserver.com";
    license = lib.licenses.asl20;
    mainProgram = "caddy";
    platforms = lib.platforms.linux;
  };
}
