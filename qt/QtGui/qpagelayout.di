/****************************************************************************
**
** Copyright (C) 2014 John Layt <jlayt@kde.org>
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

#ifndef QPAGELAYOUT_H
#define QPAGELAYOUT_H

public import qt.QtCore.qsharedpointer;
public import qt.QtCore.qstring;
public import qt.QtCore.qmargins;

public import qt.QtGui.qpagesize;

QT_BEGIN_NAMESPACE

class QPageLayoutPrivate;
class QMarginsF;

class Q_GUI_EXPORT QPageLayout
{
public:

    // NOTE: Must keep in sync with QPageSize::Unit and QPrinter::Unit
    enum Unit {
        Millimeter,
        Point,
        Inch,
        Pica,
        Didot,
        Cicero
    };

    // NOTE: Must keep in sync with QPrinter::Orientation
    enum Orientation {
        Portrait,
        Landscape
    };

    enum Mode {
        StandardMode,  // Paint Rect includes margins
        FullPageMode   // Paint Rect excludes margins
    };

    QPageLayout();
    QPageLayout(ref const(QPageSize) pageSize, Orientation orientation,
                ref const(QMarginsF) margins, Unit units = Point,
                ref const(QMarginsF) minMargins = QMarginsF(0, 0, 0, 0));
    QPageLayout(ref const(QPageLayout) other);
    ~QPageLayout();

    QPageLayout &operator=(ref const(QPageLayout) other);
 #ifdef Q_COMPILER_RVALUE_REFS
    QPageLayout &operator=(QPageLayout &&other) { swap(other); return *this; }
#endif

    void swap(QPageLayout &other) { d.swap(other.d); }

    friend Q_GUI_EXPORT bool operator==(ref const(QPageLayout) lhs, ref const(QPageLayout) rhs);
    bool isEquivalentTo(ref const(QPageLayout) other) const;

    bool isValid() const;

    void setMode(Mode mode);
    Mode mode() const;

    void setPageSize(ref const(QPageSize) pageSize,
                     ref const(QMarginsF) minMargins = QMarginsF(0, 0, 0, 0));
    QPageSize pageSize() const;

    void setOrientation(Orientation orientation);
    Orientation orientation() const;

    void setUnits(Unit units);
    Unit units() const;

    bool setMargins(ref const(QMarginsF) margins);
    bool setLeftMargin(qreal leftMargin);
    bool setRightMargin(qreal rightMargin);
    bool setTopMargin(qreal topMargin);
    bool setBottomMargin(qreal bottomMargin);

    QMarginsF margins() const;
    QMarginsF margins(Unit units) const;
    QMargins marginsPoints() const;
    QMargins marginsPixels(int resolution) const;

    void setMinimumMargins(ref const(QMarginsF) minMargins);
    QMarginsF minimumMargins() const;
    QMarginsF maximumMargins() const;

    QRectF fullRect() const;
    QRectF fullRect(Unit units) const;
    QRect fullRectPoints() const;
    QRect fullRectPixels(int resolution) const;

    QRectF paintRect() const;
    QRectF paintRect(Unit units) const;
    QRect paintRectPoints() const;
    QRect paintRectPixels(int resolution) const;

private:
    friend class QPageLayoutPrivate;
    QExplicitlySharedDataPointer<QPageLayoutPrivate> d;
};

Q_DECLARE_SHARED(QPageLayout)

Q_GUI_EXPORT bool operator==(ref const(QPageLayout) lhs, ref const(QPageLayout) rhs);
/+inline+/ bool operator!=(ref const(QPageLayout) lhs, ref const(QPageLayout) rhs)
{ return !operator==(lhs, rhs); }

#ifndef QT_NO_DEBUG_STREAM
Q_GUI_EXPORT QDebug operator<<(QDebug dbg, ref const(QPageLayout) pageLayout);
#endif

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QPageLayout)
Q_DECLARE_METATYPE(QPageLayout::Unit)
Q_DECLARE_METATYPE(QPageLayout::Orientation)

#endif // QPAGELAYOUT_H
