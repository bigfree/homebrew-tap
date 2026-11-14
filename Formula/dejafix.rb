class Dejafix < Formula
  desc "Coding agent memory: local-first memory and judgment for AI coding agents."
  homepage "https://github.com/bigfree/dejafix"
  version "1.0.0-rc.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.1/dejafix-aarch64-apple-darwin.tar.xz"
      sha256 "5f068bf6c6f6f71d7e8c5cd6e7f182e552f79724d0f0adf02b6049d2e4a1480e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.1/dejafix-x86_64-apple-darwin.tar.xz"
      sha256 "8e97b9b951ba7ae2fc40cd31fb57587ea494536988cfac1509ef86fd48c4b81e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.1/dejafix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bbf05cd7c9bad26b7776adf2cc1cd0235c7d30ee4eccef65b27497a6a614dcc3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.1/dejafix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "83fac9926febc6bc1a94b9015a1d7b8c2ab4da79149e3e7873eb56345dfc7750"
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
