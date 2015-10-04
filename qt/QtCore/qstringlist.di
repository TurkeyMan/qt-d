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

public import QtCore.qalgorithms;
public import QtCore.qdatastream;
public import QtCore.qlist;
public import QtCore.qregexp;
public import QtCore.qstring;
public import QtCore.qstringmatcher;


extern(C++) class QRegExp;
extern(C++) class QRegularExpression;

typedef QListIterator<QString> QStringListIterator;
typedef QMutableListIterator<QString> QMutableStringListIterator;

extern(C++) class QStringList : QList<QString>
{
public:
    /+inline+/ QStringList() { }
    /+inline+/ explicit QStringList(ref const(QString) i) { append(i); }
    /+inline+/ QStringList(ref const(QList<QString>) l) : QList<QString>(l) { }
#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QStringList(QList<QString> &&l) : QList<QString>(std::move(l)) { }
#endif
#ifdef Q_COMPILER_INITIALIZER_LISTS
    /+inline+/ QStringList(std::initializer_list<QString> args) : QList<QString>(args) { }
#endif

    QStringList &operator=(ref const(QList<QString>) other)
    { QList<QString>::operator=(other); return *this; }
#ifdef Q_COMPILER_RVALUE_REFS
    QStringList &operator=(QList<QString> &&other)
    { QList<QString>::operator=(std::move(other)); return *this; }
#endif

    /+inline+/ void sort(Qt.CaseSensitivity cs = Qt.CaseSensitive);
    /+inline+/ int removeDuplicates();

    /+inline+/ QString join(ref const(QString) sep) const;
    /+inline+/ QString join(QChar sep) const;

    /+inline+/ QStringList filter(ref const(QString) str, Qt.CaseSensitivity cs = Qt.CaseSensitive) const;
    /+inline+/ bool contains(ref const(QString) str, Qt.CaseSensitivity cs = Qt.CaseSensitive) const;

    /+inline+/ QStringList &replaceInStrings(ref const(QString) before, ref const(QString) after, Qt.CaseSensitivity cs = Qt.CaseSensitive);

    /+inline+/ QStringList operator+(ref const(QStringList) other) const
    { QStringList n = *this; n += other; return n; }
    /+inline+/ QStringList &operator<<(ref const(QString) str)
    { append(str); return *this; }
    /+inline+/ QStringList &operator<<(ref const(QStringList) l)
    { *this += l; return *this; }
    /+inline+/ QStringList &operator<<(ref const(QList<QString>) l)
    { *this += l; return *this; }

#ifndef QT_NO_REGEXP
    /+inline+/ QStringList filter(ref const(QRegExp) rx) const;
    /+inline+/ QStringList &replaceInStrings(ref const(QRegExp) rx, ref const(QString) after);
    /+inline+/ int indexOf(ref const(QRegExp) rx, int from = 0) const;
    /+inline+/ int lastIndexOf(ref const(QRegExp) rx, int from = -1) const;
    /+inline+/ int indexOf(QRegExp &rx, int from = 0) const;
    /+inline+/ int lastIndexOf(QRegExp &rx, int from = -1) const;
#endif

#ifndef QT_BOOTSTRAPPED
#ifndef QT_NO_REGULAREXPRESSION
    /+inline+/ QStringList filter(ref const(QRegularExpression) re) const;
    /+inline+/ QStringList &replaceInStrings(ref const(QRegularExpression) re, ref const(QString) after);
    /+inline+/ int indexOf(ref const(QRegularExpression) re, int from = 0) const;
    /+inline+/ int lastIndexOf(ref const(QRegularExpression) re, int from = -1) const;
#endif // QT_NO_REGULAREXPRESSION
#endif // QT_BOOTSTRAPPED

#if !defined(Q_NO_USING_KEYWORD)
    using QList<QString>::indexOf;
    using QList<QString>::lastIndexOf;
#else
    /+inline+/ int indexOf(ref const(QString) str, int from = 0) const
    { return QList<QString>::indexOf(str, from); }
    /+inline+/ int lastIndexOf(ref const(QString) str, int from = -1) const
    { return QList<QString>::lastIndexOf(str, from); }
#endif
}

Q_DECLARE_TYPEINFO(QStringList, Q_MOVABLE_TYPE);

namespace QtPrivate {
    void export QStringList_sort(QStringList *that, Qt.CaseSensitivity cs);
    int export QStringList_removeDuplicates(QStringList *that);
    QString export QStringList_join(const(QStringList)* that, const(QChar)* sep, int seplen);
    QStringList export QStringList_filter(const(QStringList)* that, ref const(QString) str,
                                               Qt.CaseSensitivity cs);

    bool export QStringList_contains(const(QStringList)* that, ref const(QString) str, Qt.CaseSensitivity cs);
    void export QStringList_replaceInStrings(QStringList *that, ref const(QString) before, ref const(QString) after,
                                      Qt.CaseSensitivity cs);

#ifndef QT_NO_REGEXP
    void export QStringList_replaceInStrings(QStringList *that, ref const(QRegExp) rx, ref const(QString) after);
    QStringList export QStringList_filter(const(QStringList)* that, ref const(QRegExp) re);
    int export QStringList_indexOf(const(QStringList)* that, ref const(QRegExp) rx, int from);
    int export QStringList_lastIndexOf(const(QStringList)* that, ref const(QRegExp) rx, int from);
    int export QStringList_indexOf(const(QStringList)* that, QRegExp &rx, int from);
    int export QStringList_lastIndexOf(const(QStringList)* that, QRegExp &rx, int from);
#endif

#ifndef QT_BOOTSTRAPPED
#ifndef QT_NO_REGULAREXPRESSION
    void export QStringList_replaceInStrings(QStringList *that, ref const(QRegularExpression) rx, ref const(QString) after);
    QStringList export QStringList_filter(const(QStringList)* that, ref const(QRegularExpression) re);
    int export QStringList_indexOf(const(QStringList)* that, ref const(QRegularExpression) re, int from);
    int export QStringList_lastIndexOf(const(QStringList)* that, ref const(QRegularExpression) re, int from);
#endif // QT_NO_REGULAREXPRESSION
#endif // QT_BOOTSTRAPPED
}

/+inline+/ void QStringList::sort(Qt.CaseSensitivity cs)
{
    QtPrivate::QStringList_sort(this, cs);
}

/+inline+/ int QStringList::removeDuplicates()
{
    return QtPrivate::QStringList_removeDuplicates(this);
}

/+inline+/ QString QStringList::join(ref const(QString) sep) const
{
    return QtPrivate::QStringList_join(this, sep.constData(), sep.length());
}

/+inline+/ QString QStringList::join(QChar sep) const
{
    return QtPrivate::QStringList_join(this, &sep, 1);
}

/+inline+/ QStringList QStringList::filter(ref const(QString) str, Qt.CaseSensitivity cs) const
{
    return QtPrivate::QStringList_filter(this, str, cs);
}

/+inline+/ bool QStringList::contains(ref const(QString) str, Qt.CaseSensitivity cs) const
{
    return QtPrivate::QStringList_contains(this, str, cs);
}

/+inline+/ QStringList &QStringList::replaceInStrings(ref const(QString) before, ref const(QString) after, Qt.CaseSensitivity cs)
{
    QtPrivate::QStringList_replaceInStrings(this, before, after, cs);
    return *this;
}

#ifndef QT_NO_REGEXP
/+inline+/ QStringList &QStringList::replaceInStrings(ref const(QRegExp) rx, ref const(QString) after)
{
    QtPrivate::QStringList_replaceInStrings(this, rx, after);
    return *this;
}

/+inline+/ QStringList QStringList::filter(ref const(QRegExp) rx) const
{
    return QtPrivate::QStringList_filter(this, rx);
}

/+inline+/ int QStringList::indexOf(ref const(QRegExp) rx, int from) const
{
    return QtPrivate::QStringList_indexOf(this, rx, from);
}

/+inline+/ int QStringList::lastIndexOf(ref const(QRegExp) rx, int from) const
{
    return QtPrivate::QStringList_lastIndexOf(this, rx, from);
}

/+inline+/ int QStringList::indexOf(QRegExp &rx, int from) const
{
    return QtPrivate::QStringList_indexOf(this, rx, from);
}

/+inline+/ int QStringList::lastIndexOf(QRegExp &rx, int from) const
{
    return QtPrivate::QStringList_lastIndexOf(this, rx, from);
}
#endif

#ifndef QT_BOOTSTRAPPED
#ifndef QT_NO_REGULAREXPRESSION
/+inline+/ QStringList &QStringList::replaceInStrings(ref const(QRegularExpression) rx, ref const(QString) after)
{
    QtPrivate::QStringList_replaceInStrings(this, rx, after);
    return *this;
}

/+inline+/ QStringList QStringList::filter(ref const(QRegularExpression) rx) const
{
    return QtPrivate::QStringList_filter(this, rx);
}

/+inline+/ int QStringList::indexOf(ref const(QRegularExpression) rx, int from) const
{
    return QtPrivate::QStringList_indexOf(this, rx, from);
}

/+inline+/ int QStringList::lastIndexOf(ref const(QRegularExpression) rx, int from) const
{
    return QtPrivate::QStringList_lastIndexOf(this, rx, from);
}
#endif // QT_NO_REGULAREXPRESSION
#endif // QT_BOOTSTRAPPED

#ifndef QT_NO_DATASTREAM
/+inline+/ QDataStream &operator>>(QDataStream &in, QStringList &list)
{
    return operator>>(in, static_cast<QList<QString> &>(list));
}
/+inline+/ QDataStream &operator<<(QDataStream &out, ref const(QStringList) list)
{
    return operator<<(out, static_cast<ref const(QList<QString>) >(list));
}
#endif // QT_NO_DATASTREAM

#endif // QSTRINGLIST_H