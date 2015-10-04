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

#ifndef QPROGRESSBAR_H
#define QPROGRESSBAR_H

public import qt.QtWidgets.qframe;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_PROGRESSBAR

class QProgressBarPrivate;
class QStyleOptionProgressBar;

class Q_WIDGETS_EXPORT QProgressBar : public QWidget
{
    mixin Q_OBJECT;
    Q_ENUMS(Direction)
    mixin Q_PROPERTY!(int, "minimum", "READ", "minimum", "WRITE", "setMinimum");
    mixin Q_PROPERTY!(int, "maximum", "READ", "maximum", "WRITE", "setMaximum");
    mixin Q_PROPERTY!(QString, "text", "READ", "text");
    mixin Q_PROPERTY!(int, "value", "READ", "value", "WRITE", "setValue", "NOTIFY", "valueChanged");
    mixin Q_PROPERTY!(Qt.Alignment, "alignment", "READ", "alignment", "WRITE", "setAlignment");
    mixin Q_PROPERTY!(bool, "textVisible", "READ", "isTextVisible", "WRITE", "setTextVisible");
    mixin Q_PROPERTY!(Qt.Orientation, "orientation", "READ", "orientation", "WRITE", "setOrientation");
    mixin Q_PROPERTY!(bool, "invertedAppearance", "READ", "invertedAppearance", "WRITE", "setInvertedAppearance");
    mixin Q_PROPERTY!(Direction, "textDirection", "READ", "textDirection", "WRITE", "setTextDirection");
    mixin Q_PROPERTY!(QString, "format", "READ", "format", "WRITE", "setFormat", "RESET", "resetFormat");

public:
    enum Direction { TopToBottom, BottomToTop };

    explicit QProgressBar(QWidget *parent = 0);
    ~QProgressBar();

    int minimum() const;
    int maximum() const;

    int value() const;

    /+virtual+/ QString text() const;
    void setTextVisible(bool visible);
    bool isTextVisible() const;

    Qt.Alignment alignment() const;
    void setAlignment(Qt.Alignment alignment);

    QSize sizeHint() const;
    QSize minimumSizeHint() const;

    Qt.Orientation orientation() const;

    void setInvertedAppearance(bool invert);
    bool invertedAppearance() const;
    void setTextDirection(QProgressBar::Direction textDirection);
    QProgressBar::Direction textDirection() const;

    void setFormat(ref const(QString) format);
    void resetFormat();
    QString format() const;

public Q_SLOTS:
    void reset();
    void setRange(int minimum, int maximum);
    void setMinimum(int minimum);
    void setMaximum(int maximum);
    void setValue(int value);
    void setOrientation(Qt.Orientation);

Q_SIGNALS:
    void valueChanged(int value);

protected:
    bool event(QEvent *e);
    void paintEvent(QPaintEvent *);
    void initStyleOption(QStyleOptionProgressBar *option) const;

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

#endif // QT_NO_PROGRESSBAR

QT_END_NAMESPACE

#endif // QPROGRESSBAR_H