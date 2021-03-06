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


#ifndef QDIAL_H
#define QDIAL_H

public import qt.QtWidgets.qabstractslider;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_DIAL

class QDialPrivate;
class QStyleOptionSlider;

class Q_WIDGETS_EXPORT QDial: public QAbstractSlider
{
    mixin Q_OBJECT;

    mixin Q_PROPERTY!(bool, "wrapping", "READ", "wrapping", "WRITE", "setWrapping");
    mixin Q_PROPERTY!(int, "notchSize", "READ", "notchSize");
    mixin Q_PROPERTY!(qreal, "notchTarget", "READ", "notchTarget", "WRITE", "setNotchTarget");
    mixin Q_PROPERTY!(bool, "notchesVisible", "READ", "notchesVisible", "WRITE", "setNotchesVisible");
public:
    explicit QDial(QWidget *parent = 0);

    ~QDial();

    bool wrapping() const;

    int notchSize() const;

    void setNotchTarget(double target);
    qreal notchTarget() const;
    bool notchesVisible() const;

    QSize sizeHint() const;
    QSize minimumSizeHint() const;

public Q_SLOTS:
    void setNotchesVisible(bool visible);
    void setWrapping(bool on);

protected:
    bool event(QEvent *e);
    void resizeEvent(QResizeEvent *re);
    void paintEvent(QPaintEvent *pe);

    void mousePressEvent(QMouseEvent *me);
    void mouseReleaseEvent(QMouseEvent *me);
    void mouseMoveEvent(QMouseEvent *me);

    void sliderChange(SliderChange change);
    void initStyleOption(QStyleOptionSlider *option) const;


private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

#endif  // QT_NO_DIAL

QT_END_NAMESPACE

#endif // QDIAL_H
