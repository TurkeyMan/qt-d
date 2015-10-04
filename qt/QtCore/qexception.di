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

public import QtCore.qglobal;

#ifndef QT_NO_QFUTURE

public import QtCore.qatomic;
public import QtCore.qshareddata;

#ifndef QT_NO_EXCEPTIONS
#  include <exception>
#endif


#ifndef QT_NO_EXCEPTIONS

extern(C++) class export QException : std::exception
{
public:
    /+virtual+/ void raise() const;
    /+virtual+/ QException *clone() const;
}

extern(C++) class export QUnhandledException : QException
{
public:
    void raise() const;
    QUnhandledException *clone() const;
}

namespace QtPrivate {

extern(C++) class Base;
extern(C++) class export ExceptionHolder
{
public:
    ExceptionHolder(QException *exception = 0);
    ExceptionHolder(ref const(ExceptionHolder) other);
    void operator=(ref const(ExceptionHolder) other);
    ~ExceptionHolder();
    QException *exception() const;
    QExplicitlySharedDataPointer<Base> base;
}

extern(C++) class export ExceptionStore
{
public:
    void setException(ref const(QException) e);
    bool hasException() const;
    ExceptionHolder exception();
    void throwPossibleException();
    bool hasThrown() const;
    ExceptionHolder exceptionHolder;
}

} // namespace QtPrivate

#else // QT_NO_EXCEPTIONS

namespace QtPrivate {

extern(C++) class export ExceptionStore
{
public:
    ExceptionStore() { }
    /+inline+/ void throwPossibleException() {}
}

} // namespace QtPrivate

#endif // QT_NO_EXCEPTIONS

#endif // QT_NO_QFUTURE

#endif
