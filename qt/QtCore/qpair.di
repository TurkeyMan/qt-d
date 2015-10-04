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


template <class T1, extern(C++) class T2>
struct QPair
{
    typedef T1 first_type;
    typedef T2 second_type;

    QPair() : first(), second() {}
    QPair(ref const(T1) t1, ref const(T2) t2) : first(t1), second(t2) {}
    // compiler-generated copy/move ctor/assignment operators are fine!

    template <typename TT1, typename TT2>
    QPair(const QPair<TT1, TT2> &p) : first(p.first), second(p.second) {}
    template <typename TT1, typename TT2>
    QPair &operator=(const QPair<TT1, TT2> &p)
    { first = p.first; second = p.second; return *this; }
#ifdef Q_COMPILER_RVALUE_REFS
    template <typename TT1, typename TT2>
    QPair(QPair<TT1, TT2> &&p)
        // can't use std::move here as it's not constexpr in C++11:
        : first(static_cast<TT1 &&>(p.first)), second(static_cast<TT2 &&>(p.second)) {}
    template <typename TT1, typename TT2>
    QPair &operator=(QPair<TT1, TT2> &&p)
    { first = std::move(p.first); second = std::move(p.second); return *this; }
#endif

    T1 first;
    T2 second;
}

// mark QPair<T1,T2> as complex/movable/primitive depending on the
// typeinfos of the constituents:
template<class T1, extern(C++) class T2>
extern(C++) class QTypeInfo<QPair<T1, T2> > : QTypeInfoMerger<QPair<T1, T2>, T1, T2> {} // Q_DECLARE_TYPEINFO

template <class T1, extern(C++) class T2>
Q_INLINE_TEMPLATE bool operator==(const QPair<T1, T2> &p1, const QPair<T1, T2> &p2)
{ return p1.first == p2.first && p1.second == p2.second; }

template <class T1, extern(C++) class T2>
Q_INLINE_TEMPLATE bool operator!=(const QPair<T1, T2> &p1, const QPair<T1, T2> &p2)
{ return !(p1 == p2); }

template <class T1, extern(C++) class T2>
Q_INLINE_TEMPLATE bool operator<(const QPair<T1, T2> &p1, const QPair<T1, T2> &p2)
{
    return p1.first < p2.first || (!(p2.first < p1.first) && p1.second < p2.second);
}

template <class T1, extern(C++) class T2>
Q_INLINE_TEMPLATE bool operator>(const QPair<T1, T2> &p1, const QPair<T1, T2> &p2)
{
    return p2 < p1;
}

template <class T1, extern(C++) class T2>
Q_INLINE_TEMPLATE bool operator<=(const QPair<T1, T2> &p1, const QPair<T1, T2> &p2)
{
    return !(p2 < p1);
}

template <class T1, extern(C++) class T2>
Q_INLINE_TEMPLATE bool operator>=(const QPair<T1, T2> &p1, const QPair<T1, T2> &p2)
{
    return !(p1 < p2);
}

template <class T1, extern(C++) class T2>
Q_OUTOFLINE_TEMPLATE QPair<T1, T2> qMakePair(ref const(T1) x, ref const(T2) y)
{
    return QPair<T1, T2>(x, y);
}

#endif // QPAIR_H
