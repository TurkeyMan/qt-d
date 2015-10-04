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

#ifndef QACTION_H
#define QACTION_H

public import qt.QtGui.qkeysequence;
public import qt.QtCore.qstring;
public import qt.QtWidgets.qwidget;
public import qt.QtCore.qvariant;
public import qt.QtGui.qicon;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_ACTION

class QMenu;
class QActionGroup;
class QActionPrivate;
class QGraphicsWidget;

class Q_WIDGETS_EXPORT QAction : public QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

    Q_ENUMS(MenuRole)
    Q_ENUMS(Priority)
    mixin Q_PROPERTY!(bool, "checkable", "READ", "isCheckable", "WRITE", "setCheckable", "NOTIFY", "changed");
    mixin Q_PROPERTY!(bool, "checked", "READ", "isChecked", "WRITE", "setChecked", "DESIGNABLE", "isCheckable", "NOTIFY", "toggled");
    mixin Q_PROPERTY!(bool, "enabled", "READ", "isEnabled", "WRITE", "setEnabled", "NOTIFY", "changed");
    mixin Q_PROPERTY!(QIcon, "icon", "READ", "icon", "WRITE", "setIcon", "NOTIFY", "changed");
    mixin Q_PROPERTY!(QString, "text", "READ", "text", "WRITE", "setText", "NOTIFY", "changed");
    mixin Q_PROPERTY!(QString, "iconText", "READ", "iconText", "WRITE", "setIconText", "NOTIFY", "changed");
    mixin Q_PROPERTY!(QString, "toolTip", "READ", "toolTip", "WRITE", "setToolTip", "NOTIFY", "changed");
    mixin Q_PROPERTY!(QString, "statusTip", "READ", "statusTip", "WRITE", "setStatusTip", "NOTIFY", "changed");
    mixin Q_PROPERTY!(QString, "whatsThis", "READ", "whatsThis", "WRITE", "setWhatsThis", "NOTIFY", "changed");
    mixin Q_PROPERTY!(QFont, "font", "READ", "font", "WRITE", "setFont", "NOTIFY", "changed");
#ifndef QT_NO_SHORTCUT
    mixin Q_PROPERTY!(QKeySequence, "shortcut", "READ", "shortcut", "WRITE", "setShortcut", "NOTIFY", "changed");
    mixin Q_PROPERTY!(Qt.ShortcutContext, "shortcutContext", "READ", "shortcutContext", "WRITE", "setShortcutContext", "NOTIFY", "changed");
    mixin Q_PROPERTY!(bool, "autoRepeat", "READ", "autoRepeat", "WRITE", "setAutoRepeat", "NOTIFY", "changed");
#endif
    mixin Q_PROPERTY!(bool, "visible", "READ", "isVisible", "WRITE", "setVisible", "NOTIFY", "changed");
    mixin Q_PROPERTY!(MenuRole, "menuRole", "READ", "menuRole", "WRITE", "setMenuRole", "NOTIFY", "changed");
    mixin Q_PROPERTY!(bool, "iconVisibleInMenu", "READ", "isIconVisibleInMenu", "WRITE", "setIconVisibleInMenu", "NOTIFY", "changed");
    mixin Q_PROPERTY!(Priority, "priority", "READ", "priority", "WRITE", "setPriority");

public:
    // note this is copied into qplatformmenu.h, which must stay in sync
    enum MenuRole { NoRole = 0, TextHeuristicRole, ApplicationSpecificRole, AboutQtRole,
                    AboutRole, PreferencesRole, QuitRole };
    enum Priority { LowPriority = 0,
                    NormalPriority = 128,
                    HighPriority = 256};
    explicit QAction(QObject* parent);
    QAction(ref const(QString) text, QObject* parent);
    QAction(ref const(QIcon) icon, ref const(QString) text, QObject* parent);

    ~QAction();

    void setActionGroup(QActionGroup *group);
    QActionGroup *actionGroup() const;
    void setIcon(ref const(QIcon) icon);
    QIcon icon() const;

    void setText(ref const(QString) text);
    QString text() const;

    void setIconText(ref const(QString) text);
    QString iconText() const;

    void setToolTip(ref const(QString) tip);
    QString toolTip() const;

    void setStatusTip(ref const(QString) statusTip);
    QString statusTip() const;

    void setWhatsThis(ref const(QString) what);
    QString whatsThis() const;

    void setPriority(Priority priority);
    Priority priority() const;

#ifndef QT_NO_MENU
    QMenu *menu() const;
    void setMenu(QMenu *menu);
#endif

    void setSeparator(bool b);
    bool isSeparator() const;

#ifndef QT_NO_SHORTCUT
    void setShortcut(ref const(QKeySequence) shortcut);
    QKeySequence shortcut() const;

    void setShortcuts(ref const(QList<QKeySequence>) shortcuts);
    void setShortcuts(QKeySequence::StandardKey);
    QList<QKeySequence> shortcuts() const;

    void setShortcutContext(Qt.ShortcutContext context);
    Qt.ShortcutContext shortcutContext() const;

    void setAutoRepeat(bool);
    bool autoRepeat() const;
#endif

    void setFont(ref const(QFont) font);
    QFont font() const;

    void setCheckable(bool);
    bool isCheckable() const;

    QVariant data() const;
    void setData(ref const(QVariant) var);

    bool isChecked() const;

    bool isEnabled() const;

    bool isVisible() const;

    enum ActionEvent { Trigger, Hover };
    void activate(ActionEvent event);
    bool showStatusText(QWidget *widget=0);

    void setMenuRole(MenuRole menuRole);
    MenuRole menuRole() const;

    void setIconVisibleInMenu(bool visible);
    bool isIconVisibleInMenu() const;


    QWidget *parentWidget() const;

    QList<QWidget *> associatedWidgets() const;
#ifndef QT_NO_GRAPHICSVIEW
    QList<QGraphicsWidget *> associatedGraphicsWidgets() const; // ### suboptimal
#endif

protected:
    bool event(QEvent *);
    QAction(QActionPrivate &dd, QObject *parent);

public Q_SLOTS:
    void trigger() { activate(Trigger); }
    void hover() { activate(Hover); }
    void setChecked(bool);
    void toggle();
    void setEnabled(bool);
    /+inline+/ void setDisabled(bool b) { setEnabled(!b); }
    void setVisible(bool);

Q_SIGNALS:
    void changed();
    void triggered(bool checked = false);
    void hovered();
    void toggled(bool);

private:
    mixin Q_DISABLE_COPY;

    friend class QGraphicsWidget;
    friend class QWidget;
    friend class QActionGroup;
    friend class QMenu;
    friend class QMenuPrivate;
    friend class QMenuBar;
    friend class QToolButton;
#ifdef Q_OS_MAC
    friend void qt_mac_clear_status_text(QAction *action);
#endif
};

QT_BEGIN_INCLUDE_NAMESPACE
public import qt.QtWidgets.qactiongroup;
QT_END_INCLUDE_NAMESPACE

#endif // QT_NO_ACTION

QT_END_NAMESPACE

#endif // QACTION_H
