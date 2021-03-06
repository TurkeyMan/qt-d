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

#ifndef QSCROLLER_H
#define QSCROLLER_H

public import qt.QtCore.QObject;
public import qt.QtCore.QPointF;
public import qt.QtWidgets.QScrollerProperties;

QT_BEGIN_NAMESPACE


class QWidget;
class QScrollerPrivate;
class QScrollerProperties;
#ifndef QT_NO_GESTURES
class QFlickGestureRecognizer;
class QMouseFlickGestureRecognizer;
#endif

class Q_WIDGETS_EXPORT QScroller : public QObject
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(State, "state", "READ", "state", "NOTIFY", "stateChanged");
    mixin Q_PROPERTY!(QScrollerProperties, "scrollerProperties", "READ", "scrollerProperties", "WRITE", "setScrollerProperties", "NOTIFY", "scrollerPropertiesChanged");
    Q_ENUMS(State)

public:
    enum State
    {
        Inactive,
        Pressed,
        Dragging,
        Scrolling
    };

    enum ScrollerGestureType
    {
        TouchGesture,
        LeftMouseButtonGesture,
        RightMouseButtonGesture,
        MiddleMouseButtonGesture
    };

    enum Input
    {
        InputPress = 1,
        InputMove,
        InputRelease
    };

    static bool hasScroller(QObject *target);

    static QScroller *scroller(QObject *target);
    static const(QScroller)* scroller(const(QObject)* target);

#ifndef QT_NO_GESTURES
    static Qt.GestureType grabGesture(QObject *target, ScrollerGestureType gestureType = TouchGesture);
    static Qt.GestureType grabbedGesture(QObject *target);
    static void ungrabGesture(QObject *target);
#endif

    static QList<QScroller *> activeScrollers();

    QObject *target() const;

    State state() const;

    bool handleInput(Input input, ref const(QPointF) position, qint64 timestamp = 0);

    void stop();
    QPointF velocity() const;
    QPointF finalPosition() const;
    QPointF pixelPerMeter() const;

    QScrollerProperties scrollerProperties() const;

    void setSnapPositionsX( ref const(QList<qreal>) positions );
    void setSnapPositionsX( qreal first, qreal interval );
    void setSnapPositionsY( ref const(QList<qreal>) positions );
    void setSnapPositionsY( qreal first, qreal interval );

public Q_SLOTS:
    void setScrollerProperties(ref const(QScrollerProperties) prop);
    void scrollTo(ref const(QPointF) pos);
    void scrollTo(ref const(QPointF) pos, int scrollTime);
    void ensureVisible(ref const(QRectF) rect, qreal xmargin, qreal ymargin);
    void ensureVisible(ref const(QRectF) rect, qreal xmargin, qreal ymargin, int scrollTime);
    void resendPrepareEvent();

Q_SIGNALS:
    void stateChanged(QScroller::State newstate);
    void scrollerPropertiesChanged(ref const(QScrollerProperties) );

private:
    QScrollerPrivate *d_ptr;

    QScroller(QObject *target);
    /+virtual+/ ~QScroller();

    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;

#ifndef QT_NO_GESTURES
    friend class QFlickGestureRecognizer;
#endif
};

QT_END_NAMESPACE

#endif // QSCROLLER_H
