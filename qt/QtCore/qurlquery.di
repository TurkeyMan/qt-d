/****************************************************************************
**
** Copyright (C) 2012 Intel Corporation.
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

public import QtCore.qpair;
public import QtCore.qshareddata;
public import QtCore.qurl;

#if QT_DEPRECATED_SINCE(5,0)
public import QtCore.qstringlist;
#endif

extern(C++) class QUrlQueryPrivate;
extern(C++) class export QUrlQuery
{
public:
    QUrlQuery();
    explicit QUrlQuery(ref const(QUrl) url);
    explicit QUrlQuery(ref const(QString) queryString);
    QUrlQuery(ref const(QUrlQuery) other);
    QUrlQuery &operator=(ref const(QUrlQuery) other);
#ifdef Q_COMPILER_RVALUE_REFS
    QUrlQuery &operator=(QUrlQuery &&other)
    { qSwap(d, other.d); return *this; }
#endif
    ~QUrlQuery();

    bool operator==(ref const(QUrlQuery) other) const;
    bool operator!=(ref const(QUrlQuery) other) const
    { return !(*this == other); }

    void swap(QUrlQuery &other) { qSwap(d, other.d); }

    bool isEmpty() const;
    bool isDetached() const;
    void clear();

    QString query(QUrl::ComponentFormattingOptions encoding = QUrl::PrettyDecoded) const;
    void setQuery(ref const(QString) queryString);
    QString toString(QUrl::ComponentFormattingOptions encoding = QUrl::PrettyDecoded) const
    { return query(encoding); }

    void setQueryDelimiters(QChar valueDelimiter, QChar pairDelimiter);
    QChar queryValueDelimiter() const;
    QChar queryPairDelimiter() const;

    void setQueryItems(const QList<QPair<QString, QString> > &query);
    QList<QPair<QString, QString> > queryItems(QUrl::ComponentFormattingOptions encoding = QUrl::PrettyDecoded) const;

    bool hasQueryItem(ref const(QString) key) const;
    void addQueryItem(ref const(QString) key, ref const(QString) value);
    void removeQueryItem(ref const(QString) key);
    QString queryItemValue(ref const(QString) key, QUrl::ComponentFormattingOptions encoding = QUrl::PrettyDecoded) const;
    QStringList allQueryItemValues(ref const(QString) key, QUrl::ComponentFormattingOptions encoding = QUrl::PrettyDecoded) const;
    void removeAllQueryItems(ref const(QString) key);

    static QChar defaultQueryValueDelimiter()
    { return QChar(ushort('=')); }
    static QChar defaultQueryPairDelimiter()
    { return QChar(ushort('&')); }

private:
    friend extern(C++) class QUrl;
    QSharedDataPointer<QUrlQueryPrivate> d;
public:
    typedef QSharedDataPointer<QUrlQueryPrivate> DataPtr;
    /+inline+/ DataPtr &data_ptr() { return d; }
}

Q_DECLARE_SHARED(QUrlQuery)

#if QT_DEPRECATED_SINCE(5,0)
/+inline+/ void QUrl::setQueryItems(const QList<QPair<QString, QString> > &qry)
{ QUrlQuery q(*this); q.setQueryItems(qry); setQuery(q); }
/+inline+/ void QUrl::addQueryItem(ref const(QString) key, ref const(QString) value)
{ QUrlQuery q(*this); q.addQueryItem(key, value); setQuery(q); }
/+inline+/ QList<QPair<QString, QString> > QUrl::queryItems() const
{ return QUrlQuery(*this).queryItems(); }
/+inline+/ bool QUrl::hasQueryItem(ref const(QString) key) const
{ return QUrlQuery(*this).hasQueryItem(key); }
/+inline+/ QString QUrl::queryItemValue(ref const(QString) key) const
{ return QUrlQuery(*this).queryItemValue(key); }
/+inline+/ QStringList QUrl::allQueryItemValues(ref const(QString) key) const
{ return QUrlQuery(*this).allQueryItemValues(key); }
/+inline+/ void QUrl::removeQueryItem(ref const(QString) key)
{ QUrlQuery q(*this); q.removeQueryItem(key); setQuery(q); }
/+inline+/ void QUrl::removeAllQueryItems(ref const(QString) key)
{ QUrlQuery q(*this); q.removeAllQueryItems(key); }

/+inline+/ void QUrl::addEncodedQueryItem(ref const(QByteArray) key, ref const(QByteArray) value)
{ QUrlQuery q(*this); q.addQueryItem(fromEncodedComponent_helper(key), fromEncodedComponent_helper(value)); setQuery(q); }
/+inline+/ bool QUrl::hasEncodedQueryItem(ref const(QByteArray) key) const
{ return QUrlQuery(*this).hasQueryItem(fromEncodedComponent_helper(key)); }
/+inline+/ QByteArray QUrl::encodedQueryItemValue(ref const(QByteArray) key) const
{ return QUrlQuery(*this).queryItemValue(fromEncodedComponent_helper(key), QUrl::FullyEncoded).toLatin1(); }
/+inline+/ void QUrl::removeEncodedQueryItem(ref const(QByteArray) key)
{ QUrlQuery q(*this); q.removeQueryItem(fromEncodedComponent_helper(key)); setQuery(q); }
/+inline+/ void QUrl::removeAllEncodedQueryItems(ref const(QByteArray) key)
{ QUrlQuery q(*this); q.removeAllQueryItems(fromEncodedComponent_helper(key)); }

/+inline+/ void QUrl::setEncodedQueryItems(const QList<QPair<QByteArray, QByteArray> > &qry)
{
    QUrlQuery q;
    QList<QPair<QByteArray, QByteArray> >::ConstIterator it = qry.constBegin();
    for ( ; it != qry.constEnd(); ++it)
        q.addQueryItem(fromEncodedComponent_helper(it->first), fromEncodedComponent_helper(it->second));
    setQuery(q);
}
/+inline+/ QList<QPair<QByteArray, QByteArray> > QUrl::encodedQueryItems() const
{
    QList<QPair<QString, QString> > items = QUrlQuery(*this).queryItems(QUrl::FullyEncoded);
    QList<QPair<QString, QString> >::ConstIterator it = items.constBegin();
    QList<QPair<QByteArray, QByteArray> > result;
    result.reserve(items.size());
    for ( ; it != items.constEnd(); ++it)
        result << qMakePair(it->first.toLatin1(), it->second.toLatin1());
    return result;
}
/+inline+/ QList<QByteArray> QUrl::allEncodedQueryItemValues(ref const(QByteArray) key) const
{
    QStringList items = QUrlQuery(*this).allQueryItemValues(fromEncodedComponent_helper(key), QUrl::FullyEncoded);
    QList<QByteArray> result;
    result.reserve(items.size());
    Q_FOREACH (ref const(QString) item, items)
        result << item.toLatin1();
    return result;
}
#endif

#endif // QURLQUERY_H
