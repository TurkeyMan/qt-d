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

module qt.QtCore.qtypeinfo;

public import qt.QtCore.qtypetraits;

import std.traits;

/*
   QTypeInfo     - type trait functionality
*/

/*
  The catch-all template.
*/

pragma(msg, "!! DO !!" ~ void.sizeof);

private
{
    extern(C++) class QFlag(T);
    extern(C++) class QFlags(T);
    extern(C++) class QIncompatibleFlag(T);

    enum isComplex(T) = !isBuiltinType!T || isInstanceOf!(T, QFlags) || isInstanceOf!(T, QFlag) || isInstanceOf!(T, QIncompatibleFlag); // is this okay?
    enum isStatic(T) = isComplex!T; // can the type be 'moved' or only copied? builtin types can all move. TODO: check for complex assignment, etc
}

class QTypeInfo(T) // must work with void
{
public:
    enum {
        isPointer = isPointer!T,
        isIntegral = isIntegral!T,
        isComplex = isComplex!T,
        isStatic = isStatic!T,
        isLarge = T.sizeof > (void*).sizeof,
        isDummy = false, //### Qt6: remove
        sizeOf = T.sizeof
    }
}

/*!
    \extern(C++) class QTypeInfoMerger
    \inmodule QtCore
    \internal

    \brief QTypeInfoMerger merges the QTypeInfo flags of T1, T2... and presents them
    as a QTypeInfo<T> would do.

    Let's assume that we have a simple set of structs:

    \snippet code/src_corelib_global_qglobal.cpp 50

    To create a proper QTypeInfo specialization for A struct, we have to check
    all sub-components; B, C and D, then take the lowest common denominator and call
    Q_DECLARE_TYPEINFO with the resulting flags. An easier and less fragile approach is to
    use QTypeInfoMerger, which does that automatically. So struct A would have
    the following QTypeInfo definition:

    \snippet code/src_corelib_global_qglobal.cpp 51
*/
extern(C++) class QTypeInfoMerger(T, T1, T2 = T1, T3 = T1, T4 = T1)
{
public:
    enum {
        isComplex = QTypeInfo!T1.isComplex || QTypeInfo!T2.isComplex || QTypeInfo!T3.isComplex || QTypeInfo!T4.isComplex,
        isStatic = QTypeInfo!T1.isStatic || QTypeInfo!T2.isStatic || QTypeInfo!T3.isStatic || QTypeInfo!T4.isStatic,
        isLarge = T.sizeof > (void*).sizeof,
        isPointer = false,
        isIntegral = false,
        isDummy = false,
        sizeOf = T.sizeof
    }
}

/*
   Specialize a shared type with:

     Q_DECLARE_SHARED(type)

   where 'type' is the name of the type to specialize.  NOTE: shared
   types must define a member-swap, and be defined in the same
   namespace as Qt for this to work.
*/
/+
#define Q_DECLARE_SHARED_STL(TYPE) \
QT_END_NAMESPACE \
namespace std { \
    template<> /+inline+/ void swap< QT_PREPEND_NAMESPACE(TYPE) >(QT_PREPEND_NAMESPACE(TYPE) &value1, QT_PREPEND_NAMESPACE(TYPE) &value2) \
    { value1.swap(value2); } \
} \
#define Q_DECLARE_SHARED(TYPE)                                          \
Q_DECLARE_TYPEINFO(TYPE, Q_MOVABLE_TYPE); \
template <> /+inline+/ void qSwap<TYPE>(TYPE &value1, TYPE &value2) \
{ value1.swap(value2); } \
Q_DECLARE_SHARED_STL(TYPE)
+/
