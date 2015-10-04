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

#ifndef QPEN_H
#define QPEN_H

public import qt.QtGui.qcolor;
public import qt.QtGui.qbrush;

QT_BEGIN_NAMESPACE


class QVariant;
class QPenPrivate;
class QBrush;
class QPen;

#ifndef QT_NO_DATASTREAM
Q_GUI_EXPORT QDataStream &operator<<(QDataStream &, ref const(QPen) );
Q_GUI_EXPORT QDataStream &operator>>(QDataStream &, QPen &);
#endif

class Q_GUI_EXPORT QPen
{
public:
    QPen();
    QPen(Qt.PenStyle);
    QPen(ref const(QColor) color);
    QPen(ref const(QBrush) brush, qreal width, Qt.PenStyle s = Qt.SolidLine,
         Qt.PenCapStyle c = Qt.SquareCap, Qt.PenJoinStyle j = Qt.BevelJoin);
    QPen(ref const(QPen) pen);

    ~QPen();

    QPen &operator=(ref const(QPen) pen);
#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QPen(QPen &&other)
        : d(other.d) { other.d = 0; }
    /+inline+/ QPen &operator=(QPen &&other)
    { qSwap(d, other.d); return *this; }
#endif
    /+inline+/ void swap(QPen &other) { qSwap(d, other.d); }

    Qt.PenStyle style() const;
    void setStyle(Qt.PenStyle);

    QVector<qreal> dashPattern() const;
    void setDashPattern(ref const(QVector<qreal>) pattern);

    qreal dashOffset() const;
    void setDashOffset(qreal doffset);

    qreal miterLimit() const;
    void setMiterLimit(qreal limit);

    qreal widthF() const;
    void setWidthF(qreal width);

    int width() const;
    void setWidth(int width);

    QColor color() const;
    void setColor(ref const(QColor) color);

    QBrush brush() const;
    void setBrush(ref const(QBrush) brush);

    bool isSolid() const;

    Qt.PenCapStyle capStyle() const;
    void setCapStyle(Qt.PenCapStyle pcs);

    Qt.PenJoinStyle joinStyle() const;
    void setJoinStyle(Qt.PenJoinStyle pcs);

    bool isCosmetic() const;
    void setCosmetic(bool cosmetic);

    bool operator==(ref const(QPen) p) const;
    /+inline+/ bool operator!=(ref const(QPen) p) const { return !(operator==(p)); }
    operator QVariant() const;

    bool isDetached();
private:
    friend Q_GUI_EXPORT QDataStream &operator>>(QDataStream &, QPen &);
    friend Q_GUI_EXPORT QDataStream &operator<<(QDataStream &, ref const(QPen) );

    void detach();
    class QPenPrivate *d;

public:
    typedef QPenPrivate * DataPtr;
    /+inline+/ DataPtr &data_ptr() { return d; }
};

Q_DECLARE_SHARED(QPen)

#ifndef QT_NO_DEBUG_STREAM
Q_GUI_EXPORT QDebug operator<<(QDebug, ref const(QPen) );
#endif

QT_END_NAMESPACE

#endif // QPEN_H
