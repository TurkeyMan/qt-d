/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtGui module of the Qt Toolkit.
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

#ifndef QPIXMAPCACHE_H
#define QPIXMAPCACHE_H

public import qt.QtGui.qpixmap;

#ifdef Q_TEST_QPIXMAPCACHE
public import qt.QtCore.qpair;
#endif

QT_BEGIN_NAMESPACE


class Q_GUI_EXPORT QPixmapCache
{
public:
    class KeyData;
    class Q_GUI_EXPORT Key
    {
    public:
        Key();
        Key(ref const(Key) other);
        ~Key();
        bool operator ==(ref const(Key) key) const;
        /+inline+/ bool operator !=(ref const(Key) key) const
        { return !operator==(key); }
        Key &operator =(ref const(Key) other);

    private:
        KeyData *d;
        friend class QPMCache;
        friend class QPixmapCache;
    };

    static int cacheLimit();
    static void setCacheLimit(int);
    static QPixmap *find(ref const(QString) key);
    static bool find(ref const(QString) key, QPixmap &pixmap);
    static bool find(ref const(QString) key, QPixmap *pixmap);
    static bool find(ref const(Key) key, QPixmap *pixmap);
    static bool insert(ref const(QString) key, ref const(QPixmap) pixmap);
    static Key insert(ref const(QPixmap) pixmap);
    static bool replace(ref const(Key) key, ref const(QPixmap) pixmap);
    static void remove(ref const(QString) key);
    static void remove(ref const(Key) key);
    static void clear();

#ifdef Q_TEST_QPIXMAPCACHE
    static void flushDetachedPixmaps();
    static int totalUsed();
    static QList< QPair<QString,QPixmap> > allPixmaps();
#endif
};

QT_END_NAMESPACE

#endif // QPIXMAPCACHE_H
