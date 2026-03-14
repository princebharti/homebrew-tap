class Leakfix < Formula
  desc "One-stop CLI tool to detect, remove and prevent secrets in git repositories"
  homepage "https://github.com/princebharti/leakfix"
  url "https://github.com/princebharti/leakfix/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "59b4bd6ffc994f5a216cb4531e9c14b8ee3af87f6b61898c5fd74b9882fe82c7"
  license "MIT"

  depends_on "python@3.11"
  depends_on "gitleaks"
  depends_on "git-filter-repo"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      ✅ leakfix installed!

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
