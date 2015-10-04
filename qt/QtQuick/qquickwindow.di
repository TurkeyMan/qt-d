/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtQuick module of the Qt Toolkit.
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

public import QtQuick.qtquickglobal;
public import QtCore.qmetatype;
public import QtGui.qopengl;
public import QtGui.qwindow;
public import QtGui.qevent;
public import QtQml.qqml;

extern(C++) class QRunnable;
extern(C++) class QQuickItem;
extern(C++) class QSGTexture;
extern(C++) class QInputMethodEvent;
extern(C++) class QQuickWindowPrivate;
extern(C++) class QQuickWindowAttached;
extern(C++) class QOpenGLFramebufferObject;
extern(C++) class QQmlIncubationController;
extern(C++) class QInputMethodEvent;
extern(C++) class QQuickCloseEvent;
extern(C++) class QQuickRenderControl;

extern(C++) class Q_QUICK_EXPORT QQuickWindow : QWindow
{
    mixin Q_OBJECT;
    Q_PRIVATE_PROPERTY(QQuickWindow::d_func(), QQmlListProperty<QObject> data READ data DESIGNABLE false)
    mixin Q_PROPERTY!(QColor, "color", "READ", "color", "WRITE", "setColor", "NOTIFY", "colorChanged");
    Q_PROPERTY(QQuickItem* contentItem READ contentItem CONSTANT)
    mixin Q_PROPERTY!(QQuickItem*, "activeFocusItem", "READ", "activeFocusItem", "NOTIFY", "activeFocusItemChanged", "REVISION", "1");
    Q_CLASSINFO("DefaultProperty", "data")
    mixin Q_DECLARE_PRIVATE;
public:
    enum CreateTextureOption {
        TextureHasAlphaChannel  = 0x0001,
        TextureHasMipmaps       = 0x0002,
        TextureOwnsGLTexture    = 0x0004,
        TextureCanUseAtlas      = 0x0008
    }

    enum RenderStage {
        BeforeSynchronizingStage,
        AfterSynchronizingStage,
        BeforeRenderingStage,
        AfterRenderingStage,
        AfterSwapStage
    }

    Q_DECLARE_FLAGS(CreateTextureOptions, CreateTextureOption)

    enum SceneGraphError {
        ContextNotAvailable = 1
    }
    Q_ENUMS(SceneGraphError)

    QQuickWindow(QWindow *parent = 0);
    explicit QQuickWindow(QQuickRenderControl *renderControl);

    /+virtual+/ ~QQuickWindow();

    QQuickItem *contentItem() const;

    QQuickItem *activeFocusItem() const;
    QObject *focusObject() const;

    QQuickItem *mouseGrabberItem() const;

    bool sendEvent(QQuickItem *, QEvent *);

    QImage grabWindow();

    void setRenderTarget(QOpenGLFramebufferObject *fbo);
    QOpenGLFramebufferObject *renderTarget() const;

    void setRenderTarget(uint fboId, ref const(QSize) size);
    uint renderTargetId() const;
    QSize renderTargetSize() const;

    void resetOpenGLState();

    QQmlIncubationController *incubationController() const;

#ifndef QT_NO_ACCESSIBILITY
    /+virtual+/ QAccessibleInterface *accessibleRoot() const;
#endif

    // Scene graph specific functions
    QSGTexture *createTextureFromImage(ref const(QImage) image) const;
    QSGTexture *createTextureFromImage(ref const(QImage) image, CreateTextureOptions options) const;
    QSGTexture *createTextureFromId(uint id, ref const(QSize) size, CreateTextureOptions options = CreateTextureOption(0)) const;

    void setClearBeforeRendering(bool enabled);
    bool clearBeforeRendering() const;

    void setColor(ref const(QColor) color);
    QColor color() const;

    static bool hasDefaultAlphaBuffer();
    static void setDefaultAlphaBuffer(bool useAlpha);

    void setPersistentOpenGLContext(bool persistent);
    bool isPersistentOpenGLContext() const;

    void setPersistentSceneGraph(bool persistent);
    bool isPersistentSceneGraph() const;

    QOpenGLContext *openglContext() const;

    void scheduleRenderJob(QRunnable *job, RenderStage schedule);

    qreal effectiveDevicePixelRatio() const;

Q_SIGNALS:
    void frameSwapped();
    Q_REVISION(2) void openglContextCreated(QOpenGLContext *context);
    void sceneGraphInitialized();
    void sceneGraphInvalidated();
    void beforeSynchronizing();
    Q_REVISION(2) void afterSynchronizing();
    void beforeRendering();
    void afterRendering();
    Q_REVISION(2) void afterAnimating();
    Q_REVISION(2) void sceneGraphAboutToStop();

    Q_REVISION(1) void closing(QQuickCloseEvent *close);
    void colorChanged(ref const(QColor) );
    Q_REVISION(1) void activeFocusItemChanged();
    Q_REVISION(2) void sceneGraphError(QQuickWindow::SceneGraphError error, ref const(QString) message);


public Q_SLOTS:
    void update();
    void releaseResources();

protected:
    QQuickWindow(QQuickWindowPrivate &dd, QWindow *parent = 0);

    /+virtual+/ void exposeEvent(QExposeEvent *);
    /+virtual+/ void resizeEvent(QResizeEvent *);

    /+virtual+/ void showEvent(QShowEvent *);
    /+virtual+/ void hideEvent(QHideEvent *);
    // TODO Qt 6: reimplement QWindow::closeEvent to emit closing

    /+virtual+/ void focusInEvent(QFocusEvent *);
    /+virtual+/ void focusOutEvent(QFocusEvent *);

    /+virtual+/ bool event(QEvent *);
    /+virtual+/ void keyPressEvent(QKeyEvent *);
    /+virtual+/ void keyReleaseEvent(QKeyEvent *);
    /+virtual+/ void mousePressEvent(QMouseEvent *);
    /+virtual+/ void mouseReleaseEvent(QMouseEvent *);
    /+virtual+/ void mouseDoubleClickEvent(QMouseEvent *);
    /+virtual+/ void mouseMoveEvent(QMouseEvent *);
#ifndef QT_NO_WHEELEVENT
    /+virtual+/ void wheelEvent(QWheelEvent *);
#endif

private Q_SLOTS:
    void maybeUpdate();
    void cleanupSceneGraph();
    void forcePolish();
    void setTransientParent_helper(QQuickWindow *window);
    void runJobsAfterSwap();

private:
    friend extern(C++) class QQuickItem;
    friend extern(C++) class QQuickWidget;
    friend extern(C++) class QQuickRenderControl;
    friend extern(C++) class QQuickAnimatorController;
    mixin Q_DISABLE_COPY;
}

Q_DECLARE_METATYPE(QQuickWindow *)


