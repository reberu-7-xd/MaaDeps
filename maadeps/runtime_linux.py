import os
from pathlib import Path
import subprocess

from .common import resdir

exclude = [
    "*onnxruntime_providers_shared*",
]

def set_rpath(file, rpath):
    subprocess.check_call(["patchelf", "--set-rpath", rpath, file])

def is_elf(file):
    with open(file, "rb") as f:
        return f.read(4) == b"\x7fELF"

def install_runtime(target):
    from . import vcpkg
    prefix = Path(vcpkg.install_prefix)
    target = Path(target)
    from .runtime import install_file, match_patterns
    for file in prefix.glob("lib/**/*"):
        if (match_patterns(file, exclude)):
            continue
        if file.is_symlink() or not file.is_file():
            continue
        if is_elf(file):
            target_path = target / file.name
            install_file(file, target_path)
            set_rpath(target_path, '$ORIGIN')