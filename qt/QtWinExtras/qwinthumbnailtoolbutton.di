/****************************************************************************
 **
 ** Copyright (C) 2013 Ivan Vizir <define-true-false@yandex.com>
 ** Contact: http://www.qt-project.org/legal
 **
 ** This file is part of the QtWinExtras module of the Qt Toolkit.
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

#ifndef QWINTHUMBNAILTOOLBUTTON_H
#define QWINTHUMBNAILTOOLBUTTON_H

public import qt.QtGui.qicon;
public import qt.QtCore.qobject;
public import qt.QtCore.qscopedpointer;
public import qt.QtWinExtras.qwinextrasglobal;

QT_BEGIN_NAMESPACE

class QWinThumbnailToolButtonPrivate;

class Q_WINEXTRAS_EXPORT QWinThumbnailToolButton : public QObject
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QString, "toolTip", "READ", "toolTip", "WRITE", "setToolTip");
    mixin Q_PROPERTY!(QIcon, "icon", "READ", "icon", "WRITE", "setIcon");
    mixin Q_PROPERTY!(bool, "enabled", "READ", "isEnabled", "WRITE", "setEnabled");
    mixin Q_PROPERTY!(bool, "interactive", "READ", "isInteractive", "WRITE", "setInteractive");
    mixin Q_PROPERTY!(bool, "visible", "READ", "isVisible", "WRITE", "setVisible");
    mixin Q_PROPERTY!(bool, "dismissOnClick", "READ", "dismissOnClick", "WRITE", "setDismissOnClick");
    mixin Q_PROPERTY!(bool, "flat", "READ", "isFlat", "WRITE", "setFlat");

public:
    explicit QWinThumbnailToolButton(QObject *parent = 0);
    ~QWinThumbnailToolButton();

    void setToolTip(ref const(QString) toolTip);
    QString toolTip() const;
    void setIcon(ref const(QIcon) icon);
    QIcon icon() const;
    void setEnabled(bool enabled);
    bool isEnabled() const;
    void setInteractive(bool interactive);
    bool isInteractive() const;
    void setVisible(bool visible);
    bool isVisible() const;
    void setDismissOnClick(bool dismiss);
    bool dismissOnClick() const;
    void setFlat(bool flat);
    bool isFlat() const;

public Q_SLOTS:
    void click();

Q_SIGNALS:
    void clicked();
    void changed();

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    QScopedPointer<QWinThumbnailToolButtonPrivate> d_ptr;
    friend class QWinThumbnailToolBar;
};

QT_END_NAMESPACE

#endif // QWINTHUMBNAILTOOLBUTTON_H
