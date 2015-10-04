/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtCore module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL21$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia. For licensing terms and
** conditions see http://qt.digia.com/licensing. For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file. Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights. These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** $QT_END_LICENSE$
**
****************************************************************************/

module qt.QtCore.qsystemdetection;

public import qt.QtCore.qglobal;

/*
   The operating system, must be one of: (Q_OS_x)

     DARWIN   - Any Darwin system
     MAC      - OS X and iOS
     OSX      - OS X
     IOS      - iOS
     MSDOS    - MS-DOS and Windows
     OS2      - OS/2
     OS2EMX   - XFree86 on OS/2 (not PM)
     WIN32    - Win32 (Windows 2000/XP/Vista/7 and Windows Server 2003/2008)
     WINCE    - WinCE (Windows CE 5.0)
     WINRT    - WinRT (Windows 8 Runtime)
     CYGWIN   - Cygwin
     SOLARIS  - Sun Solaris
     HPUX     - HP-UX
     ULTRIX   - DEC Ultrix
     LINUX    - Linux [has variants]
     FREEBSD  - FreeBSD [has variants]
     NETBSD   - NetBSD
     OPENBSD  - OpenBSD
     BSDI     - BSD/OS
     IRIX     - SGI Irix
     OSF      - HP Tru64 UNIX
     SCO      - SCO OpenServer 5
     UNIXWARE - UnixWare 7, Open UNIX 8
     AIX      - AIX
     HURD     - GNU Hurd
     DGUX     - DG/UX
     RELIANT  - Reliant UNIX
     DYNIX    - DYNIX/ptx
     QNX      - QNX [has variants]
     QNX6     - QNX RTP 6.1
     LYNX     - LynxOS
     BSD4     - Any BSD 4.4 system
     UNIX     - Any UNIX BSD/SYSV system
     ANDROID  - Android platform

   The following operating systems have variants:
     LINUX    - both Q_OS_LINUX and Q_OS_ANDROID are defined when building for Android
              - only Q_OS_LINUX is defined if building for other Linux systems
     QNX      - both Q_OS_QNX and Q_OS_BLACKBERRY are defined when building for Blackberry 10
              - only Q_OS_QNX is defined if building for other QNX targets
     FREEBSD  - Q_OS_FREEBSD is defined only when building for FreeBSD with a BSD userland
              - Q_OS_FREEBSD_KERNEL is always defined on FreeBSD, even if the userland is from GNU
*/
version(OSX)
{
    version = Q_OS_DARWIN;
    version = Q_OS_BSD4;
    version(D_LP64)
        version = Q_OS_DARWIN64;
    else
        version = Q_OS_DARWIN32;
}
else version(Android)
{
    version = Q_OS_ANDROID;
    version = Q_OS_LINUX;
}
else version(Cygwin)
{
    version = Q_OS_CYGWIN;
}
else version(Win64)
{
    version = Q_OS_WIN32;
    version = Q_OS_WIN64;
}
else version(Win32)
{
    version(Windows)
    {
        version = Q_OS_WIN32;
    }
    else
    {
/+
#elif !defined(SAG_COM) && (defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__))
#  if defined(WINCE) || defined(_WIN32_WCE)
#    define Q_OS_WINCE
#  elif defined(WINAPI_FAMILY)
#    if WINAPI_FAMILY==WINAPI_FAMILY_PHONE_APP
#      define Q_OS_WINPHONE
#      define Q_OS_WINRT
#    elif WINAPI_FAMILY==WINAPI_FAMILY_APP
#      define Q_OS_WINRT
#    else
#      define Q_OS_WIN32
#    endif
#  else
#    define Q_OS_WIN32
#  endif
+/
    }
}
else version(Solaris)
{
    version = Q_OS_SOLARIS;
}
/+
#elif defined(hpux) || defined(__hpux)
#  define Q_OS_HPUX
#elif defined(__ultrix) || defined(ultrix)
#  define Q_OS_ULTRIX
#elif defined(sinix)
#  define Q_OS_RELIANT
#elif defined(__native_client__)
#  define Q_OS_NACL
+/
else version(linux)
{
    version = Q_OS_LINUX;
}
else version(FreeBSD)
{
    version = Q_OS_FREEBSD;
    version = Q_OS_FREEBSD_KERNEL;
    version = Q_OS_BSD4;
}
else version(NetBSD)
{
    version = Q_OS_NETBSD;
    version = Q_OS_BSD4;
}
else version(OpenBSD)
{
    version = Q_OS_OPENBSD;
    version = Q_OS_BSD4;
}
/+
#elif defined(__bsdi__)
#  define Q_OS_BSDI
#  define Q_OS_BSD4
#elif defined(__sgi)
#  define Q_OS_IRIX
#elif defined(__osf__)
#  define Q_OS_OSF
+/
else version(AIX)
{
    version = Q_OS_AIX;
}
/+
#elif defined(__Lynx__)
#  define Q_OS_LYNX
+/
else version(Hurd)
{
    version = Q_OS_HURD;
}
/+
#elif defined(__DGUX__)
#  define Q_OS_DGUX
#elif defined(__QNXNTO__)
#  define Q_OS_QNX
#elif defined(_SEQUENT_)
#  define Q_OS_DYNIX
#elif defined(_SCO_DS) /* SCO OpenServer 5 + GCC */
#  define Q_OS_SCO
#elif defined(__USLC__) /* all SCO platforms + UDK or OUDK */
#  define Q_OS_UNIXWARE
#elif defined(__svr4__) && defined(i386) /* Open UNIX 8 + GCC */
#  define Q_OS_UNIXWARE
#elif defined(__INTEGRITY)
#  define Q_OS_INTEGRITY
#elif defined(VXWORKS) /* there is no "real" VxWorks define - this has to be set in the mkspec! */
#  define Q_OS_VXWORKS
#elif defined(__MAKEDEPEND__)
#else
#  error "Qt has not been ported to this OS - see http://www.qt-project.org/"
#endif
+/
else
{
    static assert(false, "Qt-D has not been ported to this OS - see http://www.qt-project.org/");
}

version(Windows)
{
    version = Q_OS_WIN;
}

version(Q_OS_DARWIN)
{
    version = Q_OS_MAC;
    version(Q_OS_DARWIN64)
        version = Q_OS_MAC64;
    version(Q_OS_DARWIN32)
        version = Q_OS_MAC32;
/+
public import TargetConditionals;
#  if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
#     define Q_OS_IOS
#  elif defined(TARGET_OS_MAC) && TARGET_OS_MAC
#     define Q_OS_OSX
#     define Q_OS_MACX // compatibility synonym
#  endif
+/
}

/+
#if defined(Q_OS_WIN)
#  undef Q_OS_UNIX
#elif !defined(Q_OS_UNIX)
#  define Q_OS_UNIX
#endif
+/
version(Q_OS_WIN) {}
else version(Q_OS_UNIX) {} else {
    version = Q_OS_UNIX;
}

version(Q_OS_DARWIN)
{
/+
public import Availability;
public import AvailabilityMacros;
+/
    version(Q_OS_OSX)
    {
/+
#    if !defined(__MAC_OS_X_VERSION_MIN_REQUIRED) || __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_6
#       undef __MAC_OS_X_VERSION_MIN_REQUIRED
#       define __MAC_OS_X_VERSION_MIN_REQUIRED __MAC_10_6
#    endif
#    if !defined(MAC_OS_X_VERSION_MIN_REQUIRED) || MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_X_VERSION_10_6
#       undef MAC_OS_X_VERSION_MIN_REQUIRED
#       define MAC_OS_X_VERSION_MIN_REQUIRED MAC_OS_X_VERSION_10_6
#    endif
+/
    }
/+
#  // Numerical checks are preferred to named checks, but to be safe
#  // we define the missing version names in case Qt uses them.
#
#  if !defined(__MAC_10_7)
#       define __MAC_10_7 1070
#  endif
#  if !defined(__MAC_10_8)
#       define __MAC_10_8 1080
#  endif
#  if !defined(__MAC_10_9)
#       define __MAC_10_9 1090
#  endif
#  if !defined(__MAC_10_10)
#       define __MAC_10_10 101000
#  endif
#  if !defined(MAC_OS_X_VERSION_10_7)
#       define MAC_OS_X_VERSION_10_7 1070
#  endif
#  if !defined(MAC_OS_X_VERSION_10_8)
#       define MAC_OS_X_VERSION_10_8 1080
#  endif
#  if !defined(MAC_OS_X_VERSION_10_9)
#       define MAC_OS_X_VERSION_10_9 1090
#  endif
#  if !defined(MAC_OS_X_VERSION_10_10)
#       define MAC_OS_X_VERSION_10_10 101000
#  endif
#
#  if !defined(__IPHONE_4_3)
#       define __IPHONE_4_3 40300
#  endif
#  if !defined(__IPHONE_5_0)
#       define __IPHONE_5_0 50000
#  endif
#  if !defined(__IPHONE_5_1)
#       define __IPHONE_5_1 50100
#  endif
#  if !defined(__IPHONE_6_0)
#       define __IPHONE_6_0 60000
#  endif
#  if !defined(__IPHONE_6_1)
#       define __IPHONE_6_1 60100
#  endif
#  if !defined(__IPHONE_7_0)
#       define __IPHONE_7_0 70000
#  endif
#  if !defined(__IPHONE_7_1)
#       define __IPHONE_7_1 70100
#  endif
#  if !defined(__IPHONE_8_0)
#       define __IPHONE_8_0 80000
#  endif
+/
}

/+
#ifdef __LSB_VERSION__
#  if __LSB_VERSION__ < 40
#    error "This version of the Linux Standard Base is unsupported"
#  endif
#ifndef QT_LINUXBASE
#  define QT_LINUXBASE
#endif
#endif
+/
