{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
}:

buildPythonPackage rec {
  pname = "vroom";
  version = "0.14.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "google";
    repo = "vroom";
    rev = "v${version}";
    hash = "sha256-aVo60R2Q2i6XaLC/tDl+g2Q/ph/LWcaOi69PgiAWpgQ=";
  };

  # No tests
  doCheck = false;

  pythonImportsCheck = [
    "vroom"
  ];

  meta = with lib; {
    description = "Launch vim tests";
    homepage = "https://github.com/google/vroom";
    license = licenses.asl20;
    maintainers = with maintainers; [ dimitrijer ];
  };
}
