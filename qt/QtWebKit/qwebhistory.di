/*
    Copyright (C) 2008 Nokia Corporation and/or its subsidiary(-ies)

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public License
    along with this library; see the file COPYING.LIB.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
*/

#ifndef QWEBHISTORY_H
#define QWEBHISTORY_H

public import qt.QtCore.qurl;
public import qt.QtCore.qstring;
public import qt.QtCore.qdatetime;
public import qt.QtCore.qshareddata;
public import qt.QtGui.qicon;

public import qt.qwebkitglobal;

class QWebPage;

namespace WebCore {
    class FrameLoaderClientQt;
}

class QWebHistoryItemPrivate;

class QWEBKIT_EXPORT QWebHistoryItem {
public:
    QWebHistoryItem(ref const(QWebHistoryItem) other);
    QWebHistoryItem &operator=(ref const(QWebHistoryItem) other);
    ~QWebHistoryItem();

    QUrl originalUrl() const;
    QUrl url() const;

    QString title() const;
    QDateTime lastVisited() const;

    QIcon icon() const;

    QVariant userData() const;
    void setUserData(ref const(QVariant) userData);

    bool isValid() const;

private:
    QWebHistoryItem(QWebHistoryItemPrivate *priv);
    friend class QWebHistory;
    friend class QWebPage;
    friend class WebCore::FrameLoaderClientQt;
    friend class QWebHistoryItemPrivate;
    friend class DumpRenderTreeSupportQt;
    //friend QDataStream & operator<<(QDataStream& out,ref const(QWebHistoryItem) hist);
    //friend QDataStream & operator>>(QDataStream& in,QWebHistoryItem& hist);
    QExplicitlySharedDataPointer<QWebHistoryItemPrivate> d;
};


class QWebHistoryPrivate;
class QWEBKIT_EXPORT QWebHistory {
public:
    void clear();

    QList<QWebHistoryItem> items() const;
    QList<QWebHistoryItem> backItems(int maxItems) const;
    QList<QWebHistoryItem> forwardItems(int maxItems) const;

    bool canGoBack() const;
    bool canGoForward() const;

    void back();
    void forward();
    void goToItem(ref const(QWebHistoryItem) item);

    QWebHistoryItem backItem() const;
    QWebHistoryItem currentItem() const;
    QWebHistoryItem forwardItem() const;
    QWebHistoryItem itemAt(int i) const;

    int currentItemIndex() const;

    int count() const;

    int maximumItemCount() const;
    void setMaximumItemCount(int count);

private:
    QWebHistory();
    ~QWebHistory();

    friend class QWebPage;
    friend class QWebPageAdapter;
    friend QWEBKIT_EXPORT QDataStream& operator>>(QDataStream&, QWebHistory&);
    friend QWEBKIT_EXPORT QDataStream& operator<<(QDataStream&, ref const(QWebHistory));

    mixin Q_DISABLE_COPY;

    QWebHistoryPrivate *d;
};

QWEBKIT_EXPORT QDataStream& operator<<(QDataStream& stream, ref const(QWebHistory) history);
QWEBKIT_EXPORT QDataStream& operator>>(QDataStream& stream, QWebHistory& history);

#endif
