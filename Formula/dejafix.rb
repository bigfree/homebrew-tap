class Dejafix < Formula
  desc "Coding agent memory: local-first memory and judgment for AI coding agents."
  homepage "https://github.com/bigfree/dejafix"
  version "1.0.0-rc.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.3/dejafix-aarch64-apple-darwin.tar.xz"
      sha256 "88f0c0bf9649df192165795a7c151cc8688ef9085f45cce1bbbcf52dac4e5fc5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.3/dejafix-x86_64-apple-darwin.tar.xz"
      sha256 "7414bd3ea371fb728a127102ab4cdea68d83d79d9ad2b0fc33d0acc4ba01ac29"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.3/dejafix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "421583d1dc97cfcd51c0ab265cc41f830b87a06a008eeeb5fa5b0b9f7badd808"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.3/dejafix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b2699e0876419b04bb6d88261899f5d429b66e37129a6f81a223b43fb92831b3"
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
