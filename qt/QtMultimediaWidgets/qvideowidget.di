/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Toolkit.
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

#ifndef QVIDEOWIDGET_H
#define QVIDEOWIDGET_H

public import qt.QtWidgets.qwidget;

public import qt.QtMultimediaWidgets.qtmultimediawidgetdefs;
public import qt.QtMultimedia.qmediabindableinterface;

QT_BEGIN_NAMESPACE


class QMediaObject;

class QVideoWidgetPrivate;
class Q_MULTIMEDIAWIDGETS_EXPORT QVideoWidget : public QWidget, public QMediaBindableInterface
{
    mixin Q_OBJECT;
    Q_INTERFACES(QMediaBindableInterface)
    mixin Q_PROPERTY!(QMediaObject*, "mediaObject", "READ", "mediaObject", "WRITE", "setMediaObject");
    mixin Q_PROPERTY!(bool, "fullScreen", "READ", "isFullScreen", "WRITE", "setFullScreen", "NOTIFY", "fullScreenChanged");
    mixin Q_PROPERTY!(Qt.AspectRatioMode, "aspectRatioMode", "READ", "aspectRatioMode", "WRITE", "setAspectRatioMode");
    mixin Q_PROPERTY!(int, "brightness", "READ", "brightness", "WRITE", "setBrightness", "NOTIFY", "brightnessChanged");
    mixin Q_PROPERTY!(int, "contrast", "READ", "contrast", "WRITE", "setContrast", "NOTIFY", "contrastChanged");
    mixin Q_PROPERTY!(int, "hue", "READ", "hue", "WRITE", "setHue", "NOTIFY", "hueChanged");
    mixin Q_PROPERTY!(int, "saturation", "READ", "saturation", "WRITE", "setSaturation", "NOTIFY", "saturationChanged");

public:
    QVideoWidget(QWidget *parent = 0);
    ~QVideoWidget();

    QMediaObject *mediaObject() const;

#ifdef Q_QDOC
    bool isFullScreen() const;
#endif

    Qt.AspectRatioMode aspectRatioMode() const;

    int brightness() const;
    int contrast() const;
    int hue() const;
    int saturation() const;

    QSize sizeHint() const;

public Q_SLOTS:
    void setFullScreen(bool fullScreen);
    void setAspectRatioMode(Qt.AspectRatioMode mode);
    void setBrightness(int brightness);
    void setContrast(int contrast);
    void setHue(int hue);
    void setSaturation(int saturation);

Q_SIGNALS:
    void fullScreenChanged(bool fullScreen);
    void brightnessChanged(int brightness);
    void contrastChanged(int contrast);
    void hueChanged(int hue);
    void saturationChanged(int saturation);

protected:
    bool event(QEvent *event);
    void showEvent(QShowEvent *event);
    void hideEvent(QHideEvent *event);
    void resizeEvent(QResizeEvent *event);
    void moveEvent(QMoveEvent *event);
    void paintEvent(QPaintEvent *event);

    bool setMediaObject(QMediaObject *object);

#if defined(Q_WS_WIN)
    bool winEvent(MSG *message, long *result);
#endif

    QVideoWidget(QVideoWidgetPrivate &dd, QWidget *parent);
    QVideoWidgetPrivate *d_ptr;

private:
    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_serviceDestroyed())
    Q_PRIVATE_SLOT(d_func(), void _q_brightnessChanged(int))
    Q_PRIVATE_SLOT(d_func(), void _q_contrastChanged(int))
    Q_PRIVATE_SLOT(d_func(), void _q_hueChanged(int))
    Q_PRIVATE_SLOT(d_func(), void _q_saturationChanged(int))
    Q_PRIVATE_SLOT(d_func(), void _q_fullScreenChanged(bool))
    Q_PRIVATE_SLOT(d_func(), void _q_dimensionsChanged())
};

QT_END_NAMESPACE


#endif
