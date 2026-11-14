class Dejafix < Formula
  desc "Coding agent memory: local-first memory and judgment for AI coding agents."
  homepage "https://github.com/bigfree/dejafix"
  version "1.0.0-rc.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.2/dejafix-aarch64-apple-darwin.tar.xz"
      sha256 "ae418387969c8bcb324d8c4afa0978ffe4869540148fc7bdeb7041d0c8eb66fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.2/dejafix-x86_64-apple-darwin.tar.xz"
      sha256 "399aa6d703a8d574486b8c98ee58f0c66380ea70020be9197a6403b1a2cb925c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.2/dejafix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a9f7ce66f2cb07fff3a3973a1fd92e4f63ce242bab764c07d99a06599bf82f58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.2/dejafix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d7ac0112eb626fc769ecf497b4e1914e53cca4ab0aab3d0fbbb141b75c053c79"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dejafix", "djf", "djf-edit-hook", "djf-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dejafix", "djf", "djf-edit-hook", "djf-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dejafix", "djf", "djf-edit-hook", "djf-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dejafix", "djf", "djf-edit-hook", "djf-mcp"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
