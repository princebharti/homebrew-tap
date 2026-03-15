class Leakfix < Formula
  desc "One-stop CLI tool to detect, remove and prevent secrets in git repositories"
  homepage "https://github.com/princebharti/leakfix"
  url "https://github.com/princebharti/leakfix/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "84defd2e5d393f627bb5776c2299e2bfe4781b6a0c1e8c4b6c4d6303b44ca43a"
  license "MIT"

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
           "watchdog", "requests", "weasyprint", "ollama", "textual"
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
