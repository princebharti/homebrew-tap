class Leakfix < Formula
  include Language::Python::Virtualenv

  desc "One-stop CLI tool to detect, remove and prevent secrets in git repositories"
  homepage "https://github.com/princebharti/leakfix"
  url "https://github.com/princebharti/leakfix/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "c99e54773dff89eeb3462fb5320d34ff1e942bcb61b81a75d714b677b49d96c9"
  license "MIT"

  depends_on "python@3.11"
  depends_on "gitleaks"
  depends_on "git-filter-repo"

  def install
    # Create a private virtualenv in libexec (not exposed to user)
    venv = virtualenv_create(libexec, "python3.11")

    # Install leakfix and all deps from PyPI using binary wheels
    # This avoids compilation issues with pydantic-core, pillow, etc.
    venv.pip_install buildpath

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
