/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtWidgets module of the Qt Toolkit.
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

#ifndef QDRAWUTIL_H
#define QDRAWUTIL_H

public import qt.QtCore.qnamespace;
#include <QtCore/qstring.h> // char*->QString conversion
public import qt.QtCore.qmargins;
public import qt.QtGui.qpixmap;
QT_BEGIN_NAMESPACE


class QPainter;
class QPalette;
class QPoint;
class QColor;
class QBrush;
class QRect;

//
// Standard shade drawing
//

Q_WIDGETS_EXPORT void qDrawShadeLine(QPainter *p, int x1, int y1, int x2, int y2,
                              ref const(QPalette) pal, bool sunken = true,
                              int lineWidth = 1, int midLineWidth = 0);

Q_WIDGETS_EXPORT void qDrawShadeLine(QPainter *p, ref const(QPoint) p1, ref const(QPoint) p2,
                              ref const(QPalette) pal, bool sunken = true,
                              int lineWidth = 1, int midLineWidth = 0);

Q_WIDGETS_EXPORT void qDrawShadeRect(QPainter *p, int x, int y, int w, int h,
                              ref const(QPalette) pal, bool sunken = false,
                              int lineWidth = 1, int midLineWidth = 0,
                              const(QBrush)* fill = 0);

Q_WIDGETS_EXPORT void qDrawShadeRect(QPainter *p, ref const(QRect) r,
                              ref const(QPalette) pal, bool sunken = false,
                              int lineWidth = 1, int midLineWidth = 0,
                              const(QBrush)* fill = 0);

Q_WIDGETS_EXPORT void qDrawShadePanel(QPainter *p, int x, int y, int w, int h,
                               ref const(QPalette) pal, bool sunken = false,
                               int lineWidth = 1, const(QBrush)* fill = 0);

Q_WIDGETS_EXPORT void qDrawShadePanel(QPainter *p, ref const(QRect) r,
                               ref const(QPalette) pal, bool sunken = false,
                               int lineWidth = 1, const(QBrush)* fill = 0);

Q_WIDGETS_EXPORT void qDrawWinButton(QPainter *p, int x, int y, int w, int h,
                              ref const(QPalette) pal, bool sunken = false,
                              const(QBrush)* fill = 0);

Q_WIDGETS_EXPORT void qDrawWinButton(QPainter *p, ref const(QRect) r,
                              ref const(QPalette) pal, bool sunken = false,
                              const(QBrush)* fill = 0);

Q_WIDGETS_EXPORT void qDrawWinPanel(QPainter *p, int x, int y, int w, int h,
                              ref const(QPalette) pal, bool sunken = false,
                             const(QBrush)* fill = 0);

Q_WIDGETS_EXPORT void qDrawWinPanel(QPainter *p, ref const(QRect) r,
                              ref const(QPalette) pal, bool sunken = false,
                             const(QBrush)* fill = 0);

Q_WIDGETS_EXPORT void qDrawPlainRect(QPainter *p, int x, int y, int w, int h, ref const(QColor) ,
                              int lineWidth = 1, const(QBrush)* fill = 0);

Q_WIDGETS_EXPORT void qDrawPlainRect(QPainter *p, ref const(QRect) r, ref const(QColor) ,
                              int lineWidth = 1, const(QBrush)* fill = 0);



struct QTileRules
{
    /+inline+/ QTileRules(Qt.TileRule horizontalRule, Qt.TileRule verticalRule)
            : horizontal(horizontalRule), vertical(verticalRule) {}
    /+inline+/ QTileRules(Qt.TileRule rule = Qt.StretchTile)
            : horizontal(rule), vertical(rule) {}
    Qt.TileRule horizontal;
    Qt.TileRule vertical;
};

#ifndef Q_QDOC
// For internal use only.
namespace QDrawBorderPixmap
{
    enum DrawingHint
    {
        OpaqueTopLeft = 0x0001,
        OpaqueTop = 0x0002,
        OpaqueTopRight = 0x0004,
        OpaqueLeft = 0x0008,
        OpaqueCenter = 0x0010,
        OpaqueRight = 0x0020,
        OpaqueBottomLeft = 0x0040,
        OpaqueBottom = 0x0080,
        OpaqueBottomRight = 0x0100,
        OpaqueCorners = OpaqueTopLeft | OpaqueTopRight | OpaqueBottomLeft | OpaqueBottomRight,
        OpaqueEdges = OpaqueTop | OpaqueLeft | OpaqueRight | OpaqueBottom,
        OpaqueFrame = OpaqueCorners | OpaqueEdges,
        OpaqueAll = OpaqueCenter | OpaqueFrame
    };

    Q_DECLARE_FLAGS(DrawingHints, DrawingHint)
}
#endif

Q_WIDGETS_EXPORT void qDrawBorderPixmap(QPainter *painter,
                                    ref const(QRect) targetRect,
                                    ref const(QMargins) targetMargins,
                                    ref const(QPixmap) pixmap,
                                    ref const(QRect) sourceRect,
                                    ref const(QMargins) sourceMargins,
                                    ref const(QTileRules) rules = QTileRules()
#ifndef Q_QDOC
                                    , QDrawBorderPixmap::DrawingHints hints = 0
#endif
                                    );

/+inline+/ void qDrawBorderPixmap(QPainter *painter,
                                           ref const(QRect) target,
                                           ref const(QMargins) margins,
                                           ref const(QPixmap) pixmap)
{
    qDrawBorderPixmap(painter, target, margins, pixmap, pixmap.rect(), margins);
}

QT_END_NAMESPACE

#endif // QDRAWUTIL_H
