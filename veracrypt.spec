%global _hardened_build 1

%define veracrypt_version 1.26.7

# This file is encoded in UTF-8.  -*- coding: utf-8 -*-
Summary:       GNU VeraCrypt text editor
Name:          veracrypt
Epoch:         1
Version:       %(echo %{veracrypt_version} | tr -s '-' '.')
Release:       1%{?dist}
License:       ASL 2.0 and TrueCrypt License 3.0
URL:           https://www.veracrypt.fr/en/Home.html
Source0:       https://www.veracrypt.fr/code/VeraCrypt/snapshot/VeraCrypt-VeraCrypt_%{veracrypt_version}.tar.gz
Patch1:        make-flags.patch

BuildRequires: fuse-devel
BuildRequires: gcc-c++
BuildRequires: make
BuildRequires: pkgconf-pkg-config
BuildRequires: wxGTK3-devel
BuildRequires: yasm

Requires:      fuse-libs
Requires:      wxGTK3
Provides:      veracrypt(bin) = %{epoch}:%{version}-%{release}

%description
VeraCrypt is a free open source disk encryption software for Windows, Mac OSX and Linux. Brought to
you by IDRIX (https://www.idrix.fr) and based on TrueCrypt 7.1a.

%prep
%autosetup -p2 -n VeraCrypt-VeraCrypt_%{veracrypt_version}/src

%build
%set_build_flags
%make_build NOSTRIP=1

%install
%make_install

# We manage the installation through the package manager.
rm -f %{buildroot}%{_bindir}/veracrypt-uninstall.sh

%files
%{_bindir}/veracrypt
%{_datadir}/applications/veracrypt.desktop
%{_datadir}/pixmaps/veracrypt.xpm
%license %{_datadir}/doc/veracrypt/License.txt
%doc %{_datadir}/doc/veracrypt/HTML/*

%changelog
* Sun Nov 22 2020 Wojciech Kozlowski <wk@wojciechkozlowski.eu> 1.24.Update7-1
- Initial spec file
