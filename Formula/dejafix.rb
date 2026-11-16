class Dejafix < Formula
  desc "Coding agent memory: local-first memory and judgment for AI coding agents."
  homepage "https://github.com/bigfree/dejafix"
  version "1.0.0-rc.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.4/dejafix-aarch64-apple-darwin.tar.xz"
      sha256 "3b850340e57f6d78e1ae0df17cb03f41752a618c55b2a6fc210b9dd68e8a20cd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.4/dejafix-x86_64-apple-darwin.tar.xz"
      sha256 "d6cb7a0cf55eeb595e2f0a6ccbab8ca1537e21cfa052631d81b4156aaf2826b5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.4/dejafix-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c006cab3789e15b6bc43171b32daba1d1bc330fa0852f2e1146681a2798eafc6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bigfree/dejafix/releases/download/v1.0.0-rc.4/dejafix-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e45c8fbc123088eaba778d1c3a4c3803dbf38cb57f09f2d2d0a445d45648564a"
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
