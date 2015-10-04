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

#ifndef QDRAG_H
#define QDRAG_H

public import qt.QtCore.qobject;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_DRAGANDDROP
class QMimeData;
class QDragPrivate;
class QPixmap;
class QPoint;
class QDragManager;


class Q_GUI_EXPORT QDrag : public QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;
public:
    explicit QDrag(QObject *dragSource);
    ~QDrag();

    void setMimeData(QMimeData *data);
    QMimeData *mimeData() const;

    void setPixmap(ref const(QPixmap) );
    QPixmap pixmap() const;

    void setHotSpot(ref const(QPoint) hotspot);
    QPoint hotSpot() const;

    QObject *source() const;
    QObject *target() const;

    Qt.DropAction start(Qt.DropActions supportedActions = Qt.CopyAction);
    Qt.DropAction exec(Qt.DropActions supportedActions = Qt.MoveAction);
    Qt.DropAction exec(Qt.DropActions supportedActions, Qt.DropAction defaultAction);

    void setDragCursor(ref const(QPixmap) cursor, Qt.DropAction action);
    QPixmap dragCursor(Qt.DropAction action) const;

    Qt.DropActions supportedActions() const;
    Qt.DropAction defaultAction() const;

Q_SIGNALS:
    void actionChanged(Qt.DropAction action);
    void targetChanged(QObject *newTarget);

private:
    friend class QDragManager;
    mixin Q_DISABLE_COPY;
};

#endif // QT_NO_DRAGANDDROP

QT_END_NAMESPACE

#endif // QDRAG_H
