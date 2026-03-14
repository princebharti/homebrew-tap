class Leakfix < Formula
  desc "One-stop CLI tool to detect, remove and prevent secrets in git repositories"
  homepage "https://github.com/princebharti/leakfix"
  url "https://github.com/princebharti/leakfix/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "03071927566af9289f5037a1ce577cfe7828b18b16158c57d251f4cc3d59ba65"
  license "MIT"
  version "1.0.1"

  depends_on "python@3.11"
  depends_on "gitleaks"
  depends_on "git-filter-repo"

  def install
    python3 = Formula["python@3.11"].opt_bin/"python3.11"
    system python3, "-m", "pip", "install",
           "--prefix=#{prefix}",
           "--no-deps",
           "."
    system python3, "-m", "pip", "install",
           "--prefix=#{prefix}",
           "click", "rich", "GitPython", "Jinja2",
           "watchdog", "requests", "weasyprint", "ollama"
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
