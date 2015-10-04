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

module qt.QtWidgets.QWidget;

public import qt.QtGui.qwindowdefs;
public import qt.QtCore.qobject;
public import qt.QtCore.qmargins;
public import qt.QtGui.qpaintdevice;
public import qt.QtGui.qpalette;
public import qt.QtGui.qfont;
public import qt.QtGui.qfontmetrics;
public import qt.QtGui.qfontinfo;
public import qt.QtWidgets.qsizepolicy;
public import qt.QtGui.qregion;
public import qt.QtGui.qbrush;
public import qt.QtGui.qcursor;
public import qt.QtGui.qkeysequence;

version(QT_INCLUDE_COMPAT)
    public import qt.QtGui.qevent;

import std.bitmanip;

class QLayout;
class QWSRegionManager;
class QStyle;
class QAction;
class QVariant;
class QWindow;
class QActionEvent;
class QMouseEvent;
class QWheelEvent;
class QHoverEvent;
class QKeyEvent;
class QFocusEvent;
class QPaintEvent;
class QMoveEvent;
class QResizeEvent;
class QCloseEvent;
class QContextMenuEvent;
class QInputMethodEvent;
class QTabletEvent;
class QDragEnterEvent;
class QDragMoveEvent;
class QDragLeaveEvent;
class QDropEvent;
class QShowEvent;
class QHideEvent;
class QIcon;
class QBackingStore;
class QPlatformWindow;
class QLocale;
class QGraphicsProxyWidget;
class QGraphicsEffect;
class QRasterWindowSurface;
class QUnifiedToolbarSurface;
class QPixmap;

extern(C++) class QWidgetData
{
public:
    WId winid;
    uint widget_attributes;
    Qt.WindowFlags window_flags;
    mixin(bitfields!(
        uint, window_state, 4,
        uint, focus_policy, 4,
        uint, sizehint_forced, 1,
        uint, is_closing, 1,
        uint, in_show, 1,
        uint, in_set_window_state, 1,
        uint, fstrut_dirty, 1,
        uint, context_menu_policy, 3,
        uint, window_modality, 2,
        uint, in_destructor, 1,
        uint, unused, 13
    ));
    QRect crect;
    QPalette pal;
    QFont fnt;
    QRect wrect;
};

class QWidgetPrivate;

extern(C++) class QWidget : QObject, QPaintDevice
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

    mixin Q_PROPERTY!(bool, "modal", "READ", "isModal");
    mixin Q_PROPERTY!(Qt.WindowModality, "windowModality", "READ", "windowModality", "WRITE", "setWindowModality");
    mixin Q_PROPERTY!(bool, "enabled", "READ", "isEnabled", "WRITE", "setEnabled");
    mixin Q_PROPERTY!(QRect, "geometry", "READ", "geometry", "WRITE", "setGeometry");
    mixin Q_PROPERTY!(QRect, "frameGeometry", "READ", "frameGeometry");
    mixin Q_PROPERTY!(QRect, "normalGeometry", "READ", "normalGeometry");
    mixin Q_PROPERTY!(int, "x", "READ", "x");
    mixin Q_PROPERTY!(int, "y", "READ", "y");
    mixin Q_PROPERTY!(QPoint, "pos", "READ", "pos", "WRITE", "move", "DESIGNABLE", "false", "STORED", "false");
    mixin Q_PROPERTY!(QSize, "frameSize", "READ", "frameSize");
    mixin Q_PROPERTY!(QSize, "size", "READ", "size", "WRITE", "resize", "DESIGNABLE", "false", "STORED", "false");
    mixin Q_PROPERTY!(int, "width", "READ", "width");
    mixin Q_PROPERTY!(int, "height", "READ", "height");
    mixin Q_PROPERTY!(QRect, "rect", "READ", "rect");
    mixin Q_PROPERTY!(QRect, "childrenRect", "READ", "childrenRect");
    mixin Q_PROPERTY!(QRegion, "childrenRegion", "READ", "childrenRegion");
    mixin Q_PROPERTY!(QSizePolicy, "sizePolicy", "READ", "sizePolicy", "WRITE", "setSizePolicy");
    mixin Q_PROPERTY!(QSize, "minimumSize", "READ", "minimumSize", "WRITE", "setMinimumSize");
    mixin Q_PROPERTY!(QSize, "maximumSize", "READ", "maximumSize", "WRITE", "setMaximumSize");
    mixin Q_PROPERTY!(int, "minimumWidth", "READ", "minimumWidth", "WRITE", "setMinimumWidth", "STORED", "false", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(int, "minimumHeight", "READ", "minimumHeight", "WRITE", "setMinimumHeight", "STORED", "false", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(int, "maximumWidth", "READ", "maximumWidth", "WRITE", "setMaximumWidth", "STORED", "false", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(int, "maximumHeight", "READ", "maximumHeight", "WRITE", "setMaximumHeight", "STORED", "false", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(QSize, "sizeIncrement", "READ", "sizeIncrement", "WRITE", "setSizeIncrement");
    mixin Q_PROPERTY!(QSize, "baseSize", "READ", "baseSize", "WRITE", "setBaseSize");
    mixin Q_PROPERTY!(QPalette, "palette", "READ", "palette", "WRITE", "setPalette");
    mixin Q_PROPERTY!(QFont, "font", "READ", "font", "WRITE", "setFont");
    version(QT_NO_CURSOR) {} else
        mixin Q_PROPERTY!(QCursor, "cursor", "READ", "cursor", "WRITE", "setCursor", "RESET", "unsetCursor");
    mixin Q_PROPERTY!(bool, "mouseTracking", "READ", "hasMouseTracking", "WRITE", "setMouseTracking");
    mixin Q_PROPERTY!(bool, "isActiveWindow", "READ", "isActiveWindow");
    mixin Q_PROPERTY!(Qt.FocusPolicy, "focusPolicy", "READ", "focusPolicy", "WRITE", "setFocusPolicy");
    mixin Q_PROPERTY!(bool, "focus", "READ", "hasFocus");
    mixin Q_PROPERTY!(Qt.ContextMenuPolicy, "contextMenuPolicy", "READ", "contextMenuPolicy", "WRITE", "setContextMenuPolicy");
    mixin Q_PROPERTY!(bool, "updatesEnabled", "READ", "updatesEnabled", "WRITE", "setUpdatesEnabled", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(bool, "visible", "READ", "isVisible", "WRITE", "setVisible", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(bool, "minimized", "READ", "isMinimized");
    mixin Q_PROPERTY!(bool, "maximized", "READ", "isMaximized");
    mixin Q_PROPERTY!(bool, "fullScreen", "READ", "isFullScreen");
    mixin Q_PROPERTY!(QSize, "sizeHint", "READ", "sizeHint");
    mixin Q_PROPERTY!(QSize, "minimumSizeHint", "READ", "minimumSizeHint");
    mixin Q_PROPERTY!(bool, "acceptDrops", "READ", "acceptDrops", "WRITE", "setAcceptDrops");
    mixin Q_PROPERTY!(QString, "windowTitle", "READ", "windowTitle", "WRITE", "setWindowTitle", "NOTIFY", "windowTitleChanged", "DESIGNABLE", "isWindow");
    mixin Q_PROPERTY!(QIcon, "windowIcon", "READ", "windowIcon", "WRITE", "setWindowIcon", "NOTIFY", "windowIconChanged", "DESIGNABLE", "isWindow");
    mixin Q_PROPERTY!(QString, "windowIconText", "READ", "windowIconText", "WRITE", "setWindowIconText", "NOTIFY", "windowIconTextChanged", "DESIGNABLE", "isWindow");
    mixin Q_PROPERTY!(double, "windowOpacity", "READ", "windowOpacity", "WRITE", "setWindowOpacity", "DESIGNABLE", "isWindow");
    mixin Q_PROPERTY!(bool, "windowModified", "READ", "isWindowModified", "WRITE", "setWindowModified", "DESIGNABLE", "isWindow");
    version(QT_NO_TOOLTIP) {} else {
        mixin Q_PROPERTY!(QString, "toolTip", "READ", "toolTip", "WRITE", "setToolTip");
        mixin Q_PROPERTY!(int, "toolTipDuration", "READ", "toolTipDuration", "WRITE", "setToolTipDuration");
    }
    version(QT_NO_STATUSTIP) {} else
        mixin Q_PROPERTY!(QString, "statusTip", "READ", "statusTip", "WRITE", "setStatusTip");
    version(QT_NO_WHATSTHIS) {} else
        mixin Q_PROPERTY!(QString, "whatsThis", "READ", "whatsThis", "WRITE", "setWhatsThis");
    version(QT_NO_ACCESSIBILITY) {} else {
        mixin Q_PROPERTY!(QString, "accessibleName", "READ", "accessibleName", "WRITE", "setAccessibleName");
        mixin Q_PROPERTY!(QString, "accessibleDescription", "READ", "accessibleDescription", "WRITE", "setAccessibleDescription");
    }
    mixin Q_PROPERTY!(Qt.LayoutDirection, "layoutDirection", "READ", "layoutDirection", "WRITE", "setLayoutDirection", "RESET", "unsetLayoutDirection");
    QDOC_PROPERTY(Qt.WindowFlags windowFlags READ windowFlags WRITE setWindowFlags)
    mixin Q_PROPERTY!(bool, "autoFillBackground", "READ", "autoFillBackground", "WRITE", "setAutoFillBackground");
    version(QT_NO_STYLE_STYLESHEET) {} else
        mixin Q_PROPERTY!(QString, "styleSheet", "READ", "styleSheet", "WRITE", "setStyleSheet");
    mixin Q_PROPERTY!(QLocale, "locale", "READ", "locale", "WRITE", "setLocale", "RESET", "unsetLocale");
    mixin Q_PROPERTY!(QString, "windowFilePath", "READ", "windowFilePath", "WRITE", "setWindowFilePath", "DESIGNABLE", "isWindow");
    mixin Q_PROPERTY!(Qt.InputMethodHints, "inputMethodHints", "READ", "inputMethodHints", "WRITE", "setInputMethodHints");

public:
    enum RenderFlag {
        DrawWindowBackground = 0x1,
        DrawChildren = 0x2,
        IgnoreMask = 0x4
    }
    mixin Q_DECLARE_FLAGS!(RenderFlags, RenderFlag);

    this(QWidget* parent = 0, Qt.WindowFlags f = 0);
    ~this();

    int devType() const;

    WId winId() const;
    void createWinId(); // internal, going away
    /+inline+/ WId internalWinId() const { return data->winid; }
    WId effectiveWinId() const;

    // GUI style setting
    QStyle *style() const;
    void setStyle(QStyle *);
    // Widget types and states

    bool isTopLevel() const;
    bool isWindow() const;

    bool isModal() const;
    Qt.WindowModality windowModality() const;
    void setWindowModality(Qt.WindowModality windowModality);

    bool isEnabled() const;
    bool isEnabledTo(const(QWidget)* ) const;
    bool isEnabledToTLW() const;

public Q_SLOTS:
    void setEnabled(bool);
    void setDisabled(bool);
    void setWindowModified(bool);

    // Widget coordinates

public:
    QRect frameGeometry() const;
    ref const(QRect) geometry() const;
    QRect normalGeometry() const;

    int x() const;
    int y() const;
    QPoint pos() const;
    QSize frameSize() const;
    QSize size() const;
    /+inline+/ int width() const;
    /+inline+/ int height() const;
    /+inline+/ QRect rect() const;
    QRect childrenRect() const;
    QRegion childrenRegion() const;

    QSize minimumSize() const;
    QSize maximumSize() const;
    int minimumWidth() const;
    int minimumHeight() const;
    int maximumWidth() const;
    int maximumHeight() const;
    void setMinimumSize(ref const(QSize) );
    void setMinimumSize(int minw, int minh);
    void setMaximumSize(ref const(QSize) );
    void setMaximumSize(int maxw, int maxh);
    void setMinimumWidth(int minw);
    void setMinimumHeight(int minh);
    void setMaximumWidth(int maxw);
    void setMaximumHeight(int maxh);

    version(Q_QDOC) {
        void setupUi(QWidget *widget);
    }

    QSize sizeIncrement() const;
    void setSizeIncrement(ref const(QSize) );
    void setSizeIncrement(int w, int h);
    QSize baseSize() const;
    void setBaseSize(ref const(QSize) );
    void setBaseSize(int basew, int baseh);

    void setFixedSize(ref const(QSize) );
    void setFixedSize(int w, int h);
    void setFixedWidth(int w);
    void setFixedHeight(int h);

    // Widget coordinate mapping

    QPoint mapToGlobal(ref const(QPoint) ) const;
    QPoint mapFromGlobal(ref const(QPoint) ) const;
    QPoint mapToParent(ref const(QPoint) ) const;
    QPoint mapFromParent(ref const(QPoint) ) const;
    QPoint mapTo(const(QWidget)* , ref const(QPoint) ) const;
    QPoint mapFrom(const(QWidget)* , ref const(QPoint) ) const;

    QWidget *window() const;
    QWidget *nativeParentWidget() const;
    /+inline+/ QWidget *topLevelWidget() const { return window(); }

    // Widget appearance functions
    ref const(QPalette) palette() const;
    void setPalette(ref const(QPalette) );

    void setBackgroundRole(QPalette.ColorRole);
    QPalette.ColorRole backgroundRole() const;

    void setForegroundRole(QPalette.ColorRole);
    QPalette.ColorRole foregroundRole() const;

    ref const(QFont) font() const;
    void setFont(ref const(QFont) );
    QFontMetrics fontMetrics() const;
    QFontInfo fontInfo() const;

    version(QT_NO_CURSOR) {} else {
        QCursor cursor() const;
        void setCursor(ref const(QCursor) );
        void unsetCursor();
    }

    void setMouseTracking(bool enable);
    bool hasMouseTracking() const;
    bool underMouse() const;

    void setMask(ref const(QBitmap) );
    void setMask(ref const(QRegion) );
    QRegion mask() const;
    void clearMask();

    void render(QPaintDevice *target, ref const(QPoint) targetOffset = QPoint(),
                ref const(QRegion) sourceRegion = QRegion(),
                RenderFlags renderFlags = RenderFlags(DrawWindowBackground | DrawChildren));

    void render(QPainter *painter, ref const(QPoint) targetOffset = QPoint(),
                ref const(QRegion) sourceRegion = QRegion(),
                RenderFlags renderFlags = RenderFlags(DrawWindowBackground | DrawChildren));

    Q_INVOKABLE QPixmap grab(ref const(QRect) rectangle = QRect(QPoint(0, 0), QSize(-1, -1)));

    version(QT_NO_GRAPHICSEFFECT) {} else {
        QGraphicsEffect *graphicsEffect() const;
        void setGraphicsEffect(QGraphicsEffect *effect);
    }

    version(QT_NO_GESTURES) {} else {
        void grabGesture(Qt.GestureType type, Qt.GestureFlags flags = Qt.GestureFlags());
        void ungrabGesture(Qt.GestureType type);
    }

public Q_SLOTS:
    void setWindowTitle(ref const(QString) );
    version(QT_NO_STYLE_STYLESHEET) {} else {
        void setStyleSheet(ref const(QString) styleSheet);
    }
public:
    version(QT_NO_STYLE_STYLESHEET) {} else {
        QString styleSheet() const;
    }
    QString windowTitle() const;
    void setWindowIcon(ref const(QIcon) icon);
    QIcon windowIcon() const;
    void setWindowIconText(ref const(QString) );
    QString windowIconText() const;
    void setWindowRole(ref const(QString) );
    QString windowRole() const;
    void setWindowFilePath(ref const(QString) filePath);
    QString windowFilePath() const;

    void setWindowOpacity(qreal level);
    qreal windowOpacity() const;

    bool isWindowModified() const;
    version(QT_NO_TOOLTIP) {} else {
        void setToolTip(ref const(QString) );
        QString toolTip() const;
        void setToolTipDuration(int msec);
        int toolTipDuration() const;
    }
    version(QT_NO_STATUSTIP) {} else {
        void setStatusTip(ref const(QString) );
        QString statusTip() const;
    }
    version(QT_NO_WHATSTHIS) {} else {
        void setWhatsThis(ref const(QString) );
        QString whatsThis() const;
    }
    version(QT_NO_ACCESSIBILITY) {} else {
        QString accessibleName() const;
        void setAccessibleName(ref const(QString) name);
        QString accessibleDescription() const;
        void setAccessibleDescription(ref const(QString) description);
    }

    void setLayoutDirection(Qt.LayoutDirection direction);
    Qt.LayoutDirection layoutDirection() const;
    void unsetLayoutDirection();

    void setLocale(ref const(QLocale) locale);
    QLocale locale() const;
    void unsetLocale();

    /+inline+/ bool isRightToLeft() const { return layoutDirection() == Qt.RightToLeft; }
    /+inline+/ bool isLeftToRight() const { return layoutDirection() == Qt.LeftToRight; }

public:// Q_SLOTS:
    @slot {
        /+inline+/ void setFocus() { setFocus(Qt.OtherFocusReason); }
    }

public:
    bool isActiveWindow() const;
    void activateWindow();
    void clearFocus();

    void setFocus(Qt.FocusReason reason);
    Qt.FocusPolicy focusPolicy() const;
    void setFocusPolicy(Qt.FocusPolicy policy);
    bool hasFocus() const;
    static void setTabOrder(QWidget *, QWidget *);
    void setFocusProxy(QWidget *);
    QWidget *focusProxy() const;
    Qt.ContextMenuPolicy contextMenuPolicy() const;
    void setContextMenuPolicy(Qt.ContextMenuPolicy policy);

    // Grab functions
    void grabMouse();
version(QT_NO_CURSOR) {} else {
    void grabMouse(ref const(QCursor) );
}
    void releaseMouse();
    void grabKeyboard();
    void releaseKeyboard();
version(QT_NO_SHORTCUT) {} else {
    int grabShortcut(ref const(QKeySequence) key, Qt.ShortcutContext context = Qt.WindowShortcut);
    void releaseShortcut(int id);
    void setShortcutEnabled(int id, bool enable = true);
    void setShortcutAutoRepeat(int id, bool enable = true);
}
    static QWidget *mouseGrabber();
    static QWidget *keyboardGrabber();

    // Update/refresh functions
    /+inline+/ bool updatesEnabled() const;
    void setUpdatesEnabled(bool enable);

version(QT_NO_GRAPHICSVIEW) {} else {
    QGraphicsProxyWidget *graphicsProxyWidget() const;
}

public:// Q_SLOTS:
    @slot {
        void update();
        void repaint();
    }
public:
    /+inline+/ void update(int x, int y, int w, int h);
    void update(ref const(QRect));
    void update(ref const(QRegion));

    void repaint(int x, int y, int w, int h);
    void repaint(ref const(QRect) );
    void repaint(ref const(QRegion) );

public Q_SLOTS:
    // Widget management functions

    /+virtual+/ void setVisible(bool visible);
    void setHidden(bool hidden);
    void show();
    void hide();

    void showMinimized();
    void showMaximized();
    void showFullScreen();
    void showNormal();

    bool close();
    void raise();
    void lower();

public:
    void stackUnder(QWidget*);
    void move(int x, int y);
    void move(ref const(QPoint) );
    void resize(int w, int h);
    void resize(ref const(QSize) );
    /+inline+/ void setGeometry(int x, int y, int w, int h);
    void setGeometry(ref const(QRect) );
    QByteArray saveGeometry() const;
    bool restoreGeometry(ref const(QByteArray) geometry);
    void adjustSize();
    bool isVisible() const;
    bool isVisibleTo(const(QWidget)* ) const;
    /+inline+/ bool isHidden() const;

    bool isMinimized() const;
    bool isMaximized() const;
    bool isFullScreen() const;

    Qt.WindowStates windowState() const;
    void setWindowState(Qt.WindowStates state);
    void overrideWindowState(Qt.WindowStates state);

    /+virtual+/ QSize sizeHint() const;
    /+virtual+/ QSize minimumSizeHint() const;

    QSizePolicy sizePolicy() const;
    void setSizePolicy(QSizePolicy);
    /+inline+/ void setSizePolicy(QSizePolicy.Policy horizontal, QSizePolicy.Policy vertical);
    /+virtual+/ int heightForWidth(int) const;
    /+virtual+/ bool hasHeightForWidth() const;

    QRegion visibleRegion() const;

    void setContentsMargins(int left, int top, int right, int bottom);
    void setContentsMargins(ref const(QMargins) margins);
    void getContentsMargins(int *left, int *top, int *right, int *bottom) const;
    QMargins contentsMargins() const;

    QRect contentsRect() const;

public:
    QLayout *layout() const;
    void setLayout(QLayout *);
    void updateGeometry();

    void setParent(QWidget *parent);
    void setParent(QWidget *parent, Qt.WindowFlags f);

    void scroll(int dx, int dy);
    void scroll(int dx, int dy, ref const(QRect));

    // Misc. functions

    QWidget *focusWidget() const;
    QWidget *nextInFocusChain() const;
    QWidget *previousInFocusChain() const;

    // drag and drop
    bool acceptDrops() const;
    void setAcceptDrops(bool on);

version(QT_NO_ACTION) {} else {
    //actions
    void addAction(QAction *action);
    void addActions(QList!(QAction*) actions);
    void insertAction(QAction *before, QAction *action);
    void insertActions(QAction *before, QList!(QAction*) actions);
    void removeAction(QAction *action);
    QList!(QAction*) actions() const;
}

    QWidget *parentWidget() const;

    void setWindowFlags(Qt.WindowFlags type);
    /+inline+/ Qt.WindowFlags windowFlags() const;
    void overrideWindowFlags(Qt.WindowFlags type);

    /+inline+/ Qt.WindowType windowType() const;

    static QWidget *find(WId);
    /+inline+/ QWidget *childAt(int x, int y) const;
    QWidget *childAt(ref const(QPoint) p) const;

version(Q_WS_X11) {
    ref const(QX11Info) x11Info() const;
    Qt.HANDLE x11PictureHandle() const;
}

version(Q_WS_MAC) {
    Qt.HANDLE macQDHandle() const;
    Qt.HANDLE macCGHandle() const;
}

    void setAttribute(Qt.WidgetAttribute, bool on = true);
    /+inline+/ bool testAttribute(Qt.WidgetAttribute) const;

    QPaintEngine *paintEngine() const;

    void ensurePolished() const;

    bool isAncestorOf(const(QWidget)* child) const;

version(QT_KEYPAD_NAVIGATION) {
    bool hasEditFocus() const;
    void setEditFocus(bool on);
}

    bool autoFillBackground() const;
    void setAutoFillBackground(bool enabled);

    QBackingStore *backingStore() const;

    QWindow *windowHandle() const;

    static QWidget *createWindowContainer(QWindow *window, QWidget *parent=0, Qt.WindowFlags flags=0);

    friend class QDesktopScreenWidget;

Q_SIGNALS:
    void windowTitleChanged(ref const(QString) title);
    void windowIconChanged(ref const(QIcon) icon);
    void windowIconTextChanged(ref const(QString) iconText);
    void customContextMenuRequested(ref const(QPoint) pos);

protected:
    // Event handlers
    bool event(QEvent *);
    /+virtual+/ void mousePressEvent(QMouseEvent *);
    /+virtual+/ void mouseReleaseEvent(QMouseEvent *);
    /+virtual+/ void mouseDoubleClickEvent(QMouseEvent *);
    /+virtual+/ void mouseMoveEvent(QMouseEvent *);
version(QT_NO_WHEELEVENT) {} else {
    /+virtual+/ void wheelEvent(QWheelEvent *);
}
    /+virtual+/ void keyPressEvent(QKeyEvent *);
    /+virtual+/ void keyReleaseEvent(QKeyEvent *);
    /+virtual+/ void focusInEvent(QFocusEvent *);
    /+virtual+/ void focusOutEvent(QFocusEvent *);
    /+virtual+/ void enterEvent(QEvent *);
    /+virtual+/ void leaveEvent(QEvent *);
    /+virtual+/ void paintEvent(QPaintEvent *);
    /+virtual+/ void moveEvent(QMoveEvent *);
    /+virtual+/ void resizeEvent(QResizeEvent *);
    /+virtual+/ void closeEvent(QCloseEvent *);
version(QT_NO_CONTEXTMENU) {} else {
    /+virtual+/ void contextMenuEvent(QContextMenuEvent *);
}
version(QT_NO_TABLETEVENT) {} else {
    /+virtual+/ void tabletEvent(QTabletEvent *);
}
version(QT_NO_ACTION) {} else {
    /+virtual+/ void actionEvent(QActionEvent *);
}

version(QT_NO_DRAGANDDROP) {} else {
    /+virtual+/ void dragEnterEvent(QDragEnterEvent *);
    /+virtual+/ void dragMoveEvent(QDragMoveEvent *);
    /+virtual+/ void dragLeaveEvent(QDragLeaveEvent *);
    /+virtual+/ void dropEvent(QDropEvent *);
}

    /+virtual+/ void showEvent(QShowEvent *);
    /+virtual+/ void hideEvent(QHideEvent *);
    /+virtual+/ bool nativeEvent(ref const(QByteArray) eventType, void *message, long *result);

    // Misc. protected functions
    /+virtual+/ void changeEvent(QEvent *);

    int metric(PaintDeviceMetric) const;
    void initPainter(QPainter *painter) const;
    QPaintDevice *redirected(QPoint *offset) const;
    QPainter *sharedPainter() const;

    /+virtual+/ void inputMethodEvent(QInputMethodEvent *);
public:
    /+virtual+/ QVariant inputMethodQuery(Qt.InputMethodQuery) const;

    Qt.InputMethodHints inputMethodHints() const;
    void setInputMethodHints(Qt.InputMethodHints hints);

protected Q_SLOTS:
    void updateMicroFocus();
protected:

    void create(WId = 0, bool initializeWindow = true,
                         bool destroyOldWindow = true);
    void destroy(bool destroyWindow = true,
                 bool destroySubWindows = true);

    /+virtual+/ bool focusNextPrevChild(bool next);
    /+inline+/ bool focusNextChild() { return focusNextPrevChild(true); }
    /+inline+/ bool focusPreviousChild() { return focusNextPrevChild(false); }

protected:
    QWidget(QWidgetPrivate &d, QWidget* parent, Qt.WindowFlags f);
private:
    void setBackingStore(QBackingStore *store);

    bool testAttribute_helper(Qt.WidgetAttribute) const;

    QLayout *takeLayout();

    friend class QBackingStoreDevice;
    friend class QWidgetBackingStore;
    friend class QApplication;
    friend class QApplicationPrivate;
    friend class QGuiApplication;
    friend class QGuiApplicationPrivate;
    friend class QBaseApplication;
    friend class QPainter;
    friend class QPainterPrivate;
    friend class QPixmap; // for QPixmap::fill()
    friend class QFontMetrics;
    friend class QFontInfo;
    friend class QLayout;
    friend class QWidgetItem;
    friend class QWidgetItemV2;
    friend class QGLContext;
    friend class QGLWidget;
    friend class QGLWindowSurface;
    friend class QX11PaintEngine;
    friend class QWin32PaintEngine;
    friend class QShortcutPrivate;
    friend class QWindowSurface;
    friend class QGraphicsProxyWidget;
    friend class QGraphicsProxyWidgetPrivate;
    friend class QStyleSheetStyle;
    friend struct QWidgetExceptionCleaner;
    friend class QWidgetWindow;
    friend class QAccessibleWidget;
    friend class QAccessibleTable;
version(QT_NO_GESTURES) {} else {
    friend class QGestureManager;
    friend class QWinNativePanGestureRecognizer;
}
    friend class QWidgetEffectSourcePrivate;

version(Q_OS_MAC) {
    friend bool qt_mac_is_metal(const(QWidget)* w);
}
    friend Q_WIDGETS_EXPORT QWidgetData *qt_qwidget_data(QWidget *widget);
    friend Q_WIDGETS_EXPORT QWidgetPrivate *qt_widget_private(QWidget *widget);

private:
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_showIfNotHidden())

    QWidgetData* data;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QWidget::RenderFlags)

version(Q_QDOC) {} else {
    template <> /+inline+/ QWidget *qobject_cast<QWidget*>(QObject *o)
    {
        if (!o || !o->isWidgetType()) return 0;
        return static_cast<QWidget*>(o);
    }
    template <> /+inline+/ const(QWidget)* qobject_cast<const QWidget*>(const(QObject)* o)
    {
        if (!o || !o->isWidgetType()) return 0;
        return static_cast<const QWidget*>(o);
    }
}

/+inline+/ QWidget *QWidget::childAt(int ax, int ay) const
{ return childAt(QPoint(ax, ay)); }

/+inline+/ Qt.WindowType QWidget::windowType() const
{ return static_cast<Qt.WindowType>(int(data->window_flags & Qt.WindowType_Mask)); }
/+inline+/ Qt.WindowFlags QWidget::windowFlags() const
{ return data->window_flags; }

/+inline+/ bool QWidget::isTopLevel() const
{ return (windowType() & Qt.Window); }

/+inline+/ bool QWidget::isWindow() const
{ return (windowType() & Qt.Window); }

/+inline+/ bool QWidget::isEnabled() const
{ return !testAttribute(Qt.WA_Disabled); }

/+inline+/ bool QWidget::isModal() const
{ return data->window_modality != Qt.NonModal; }

/+inline+/ bool QWidget::isEnabledToTLW() const
{ return isEnabled(); }

/+inline+/ int QWidget::minimumWidth() const
{ return minimumSize().width(); }

/+inline+/ int QWidget::minimumHeight() const
{ return minimumSize().height(); }

/+inline+/ int QWidget::maximumWidth() const
{ return maximumSize().width(); }

/+inline+/ int QWidget::maximumHeight() const
{ return maximumSize().height(); }

/+inline+/ void QWidget::setMinimumSize(ref const(QSize) s)
{ setMinimumSize(s.width(),s.height()); }

/+inline+/ void QWidget::setMaximumSize(ref const(QSize) s)
{ setMaximumSize(s.width(),s.height()); }

/+inline+/ void QWidget::setSizeIncrement(ref const(QSize) s)
{ setSizeIncrement(s.width(),s.height()); }

/+inline+/ void QWidget::setBaseSize(ref const(QSize) s)
{ setBaseSize(s.width(),s.height()); }

/+inline+/ ref const(QFont) QWidget::font() const
{ return data->fnt; }

/+inline+/ QFontMetrics QWidget::fontMetrics() const
{ return QFontMetrics(data->fnt); }

/+inline+/ QFontInfo QWidget::fontInfo() const
{ return QFontInfo(data->fnt); }

/+inline+/ void QWidget::setMouseTracking(bool enable)
{ setAttribute(Qt.WA_MouseTracking, enable); }

/+inline+/ bool QWidget::hasMouseTracking() const
{ return testAttribute(Qt.WA_MouseTracking); }

/+inline+/ bool QWidget::underMouse() const
{ return testAttribute(Qt.WA_UnderMouse); }

/+inline+/ bool QWidget::updatesEnabled() const
{ return !testAttribute(Qt.WA_UpdatesDisabled); }

/+inline+/ void QWidget::update(int ax, int ay, int aw, int ah)
{ update(QRect(ax, ay, aw, ah)); }

/+inline+/ bool QWidget::isVisible() const
{ return testAttribute(Qt.WA_WState_Visible); }

/+inline+/ bool QWidget::isHidden() const
{ return testAttribute(Qt.WA_WState_Hidden); }

/+inline+/ void QWidget::move(int ax, int ay)
{ move(QPoint(ax, ay)); }

/+inline+/ void QWidget::resize(int w, int h)
{ resize(QSize(w, h)); }

/+inline+/ void QWidget::setGeometry(int ax, int ay, int aw, int ah)
{ setGeometry(QRect(ax, ay, aw, ah)); }

/+inline+/ QRect QWidget::rect() const
{ return QRect(0,0,data->crect.width(),data->crect.height()); }

/+inline+/ ref const(QRect) QWidget::geometry() const
{ return data->crect; }

/+inline+/ QSize QWidget::size() const
{ return data->crect.size(); }

/+inline+/ int QWidget::width() const
{ return data->crect.width(); }

/+inline+/ int QWidget::height() const
{ return data->crect.height(); }

/+inline+/ QWidget *QWidget::parentWidget() const
{ return static_cast<QWidget *>(QObject::parent()); }

/+inline+/ void QWidget::setSizePolicy(QSizePolicy::Policy hor, QSizePolicy::Policy ver)
{ setSizePolicy(QSizePolicy(hor, ver)); }

/+inline+/ bool QWidget::testAttribute(Qt.WidgetAttribute attribute) const
{
    if (attribute < int(8*sizeof(uint)))
        return data->widget_attributes & (1<<attribute);
    return testAttribute_helper(attribute);
}

enum QWIDGETSIZE_MAX = (1<<24)-1;
