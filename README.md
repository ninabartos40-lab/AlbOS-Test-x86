# AlbOS Test x86

AlbOS Test is an experimental prototype project exploring an Android-based x86 test environment.

## Run the current prototype on Windows

1. Download this repository ZIP and extract it.
2. Double-click `run-albos-test.bat`, or open `index.html` in a browser.
3. Try Tester Mode, the simulated checks, and the generated demo beep.

The current prototype is a local browser-based interface. It is **not** Android, a bootable ISO, a VM image, or a full operating system. It does not install software or modify Windows. The beep is synthesized by the browser and is not a Nokia/Zedge recording.

## Project goal

The longer-term goal is to create an x86 virtual-machine test environment branded as AlbOS Test, based on a compatible Android x86 system and clearly identified as a prototype.

## Current contents

- `index.html` — interactive AlbOS Test UI prototype.
- `run-albos-test.bat` — opens the prototype in the default browser on Windows.

## VM concept

A real Android x86 VM requires a separately sourced system image and a build/customization process. This repository does not currently contain or redistribute such an image. Any third-party OS images and components must be used according to their respective licenses.

## Status

Early prototype. No bootable AlbOS image is available in this repository yet.
