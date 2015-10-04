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

#ifndef QSPLASHSCREEN_H
#define QSPLASHSCREEN_H

public import qt.QtGui.qpixmap;
public import qt.QtWidgets.qwidget;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_SPLASHSCREEN
class QSplashScreenPrivate;

class Q_WIDGETS_EXPORT QSplashScreen : public QWidget
{
    mixin Q_OBJECT;
public:
    explicit QSplashScreen(ref const(QPixmap) pixmap = QPixmap(), Qt.WindowFlags f = 0);
    QSplashScreen(QWidget *parent, ref const(QPixmap) pixmap = QPixmap(), Qt.WindowFlags f = 0);
    /+virtual+/ ~QSplashScreen();

    void setPixmap(ref const(QPixmap) pixmap);
    const QPixmap pixmap() const;
    void finish(QWidget *w);
    void repaint();
    QString message() const;

public Q_SLOTS:
    void showMessage(ref const(QString) message, int alignment = Qt.AlignLeft,
                  ref const(QColor) color = Qt.black);
    void clearMessage();

Q_SIGNALS:
    void messageChanged(ref const(QString) message);

protected:
    bool event(QEvent *e);
    /+virtual+/ void drawContents(QPainter *painter);
    void mousePressEvent(QMouseEvent *);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

#endif // QT_NO_SPLASHSCREEN

QT_END_NAMESPACE

#endif // QSPLASHSCREEN_H