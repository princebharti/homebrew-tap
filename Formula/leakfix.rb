class Leakfix < Formula
  include Language::Python::Virtualenv

  desc "One-stop CLI tool to detect, remove and prevent secrets in git repositories"
  homepage "https://github.com/princebharti/gitleakfix"
  url "https://github.com/princebharti/gitleakfix/archive/refs/tags/v1.7.0.tar.gz"
  sha256 "6b98171f3416594e2f5c7ae402171895fbd0c3830e4950efd84abd03055f4328"
  license "MIT"

  conflicts_with "gitleakfix", because: "gitleakfix provides the same CLI binary"

  depends_on "python@3.11"
  depends_on "gitleaks"
  depends_on "git-filter-repo"

  def install
    # Create a private virtualenv in libexec (not exposed to user)
    venv = virtualenv_create(libexec, "python3.11")

    # Install leakfix and all deps from PyPI using binary wheels
    # Using pip install directly ensures dependencies are resolved
    system libexec/"bin/python", "-m", "pip", "install", "-v",
           "--no-deps", buildpath

    # Install dependencies from PyPI (gets binary wheels, no compilation)
    system libexec/"bin/python", "-m", "pip", "install",
           "click>=8.0.0",
           "ollama>=0.1.0",
           "watchdog>=3.0.0",
           "Jinja2>=3.0.0",
           "rich>=13.0.0",
           "rich-gradient>=0.3.11",
           "GitPython>=3.1.0",
           "requests>=2.28.0",
           "questionary>=2.0.0",
           "textual>=0.60.0"

    # Symlink ONLY the leakfix binary into bin/
    # This prevents conflicts with dep binaries (pytest, rich-color, etc.)
    bin.install_symlink libexec/"bin/leakfix"
  end

  def caveats
    <<~EOS
      leakfix installed!

      Complete setup (includes optional LLM enhancement):
        leakfix setup

      Or jump straight in:
        leakfix scan        # scan current repo for secrets
        leakfix --help      # all commands

      Note: leakfix setup installs optional AI-powered false
      positive detection that runs 100% locally on your Mac.
    EOS
  end

  test do
    system "#{bin}/leakfix", "--version"
  end
end
