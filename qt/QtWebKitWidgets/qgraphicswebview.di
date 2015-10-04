/*
    Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies)

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public License
    along with this library; see the file COPYING.LIB.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
*/

#ifndef QGraphicsWebView_h
#define QGraphicsWebView_h

public import qt.QtWebKit.qwebkitglobal;
public import qt.QtWebKitWidgets.qwebpage;
public import qt.QtCore.qurl;
public import qt.QtGui.qevent;
public import qt.QtGui.qicon;
public import qt.QtGui.qpainter;
public import qt.QtNetwork.qnetworkaccessmanager;
public import qt.QtWidgets.qgraphicswidget;

#if !defined(QT_NO_GRAPHICSVIEW)

class QWebPage;
class QWebHistory;
class QWebSettings;

class QGraphicsWebViewPrivate;

class QWEBKITWIDGETS_EXPORT QGraphicsWebView : public QGraphicsWidget {
    mixin Q_OBJECT;

    mixin Q_PROPERTY!(QString, "title", "READ", "title", "NOTIFY", "titleChanged");
    mixin Q_PROPERTY!(QIcon, "icon", "READ", "icon", "NOTIFY", "iconChanged");
    mixin Q_PROPERTY!(qreal, "zoomFactor", "READ", "zoomFactor", "WRITE", "setZoomFactor");

    mixin Q_PROPERTY!(QUrl, "url", "READ", "url", "WRITE", "setUrl", "NOTIFY", "urlChanged");

    mixin Q_PROPERTY!(bool, "modified", "READ", "isModified");
    mixin Q_PROPERTY!(bool, "resizesToContents", "READ", "resizesToContents", "WRITE", "setResizesToContents");
    mixin Q_PROPERTY!(bool, "tiledBackingStoreFrozen", "READ", "isTiledBackingStoreFrozen", "WRITE", "setTiledBackingStoreFrozen");

    mixin Q_PROPERTY!(QPainter::RenderHints, "renderHints", "READ", "renderHints", "WRITE", "setRenderHints");
    Q_FLAGS(QPainter::RenderHints)

public:
    explicit QGraphicsWebView(QGraphicsItem* parent = 0);
    ~QGraphicsWebView();

    QWebPage* page() const;
    void setPage(QWebPage*);

    QUrl url() const;
    void setUrl(ref const(QUrl));

    QString title() const;
    QIcon icon() const;

    qreal zoomFactor() const;
    void setZoomFactor(qreal);

    bool isModified() const;

    void load(ref const(QUrl) url);
    void load(ref const(QNetworkRequest) request, QNetworkAccessManager::Operation operation = QNetworkAccessManager::GetOperation, ref const(QByteArray) body = QByteArray());

    void setHtml(ref const(QString) html, ref const(QUrl) baseUrl = QUrl());
    // FIXME: Consider rename to setHtml?
    void setContent(ref const(QByteArray) data, ref const(QString) mimeType = QString(), ref const(QUrl) baseUrl = QUrl());

    QWebHistory* history() const;
    QWebSettings* settings() const;

    QAction* pageAction(QWebPage::WebAction action) const;
    void triggerPageAction(QWebPage::WebAction action, bool checked = false);

    bool findText(ref const(QString) subString, QWebPage::FindFlags options = 0);

    bool resizesToContents() const;
    void setResizesToContents(bool enabled);
    
    bool isTiledBackingStoreFrozen() const;
    void setTiledBackingStoreFrozen(bool frozen);

    /+virtual+/ void setGeometry(ref const(QRectF) rect);
    /+virtual+/ void updateGeometry();
    /+virtual+/ void paint(QPainter*, const(QStyleOptionGraphicsItem)* options, QWidget* widget = 0);
    /+virtual+/ QVariant itemChange(GraphicsItemChange change, ref const(QVariant) value);
    /+virtual+/ bool event(QEvent*);

    /+virtual+/ QSizeF sizeHint(Qt.SizeHint which, ref const(QSizeF) constraint) const;

    /+virtual+/ QVariant inputMethodQuery(Qt.InputMethodQuery query) const;

    QPainter::RenderHints renderHints() const;
    void setRenderHints(QPainter::RenderHints);
    void setRenderHint(QPainter::RenderHint, bool enabled = true);

public Q_SLOTS:
    void stop();
    void back();
    void forward();
    void reload();

Q_SIGNALS:
    void loadStarted();
    void loadFinished(bool);

    void loadProgress(int progress);
    void urlChanged(ref const(QUrl));
    void titleChanged(ref const(QString));
    void iconChanged();
    void statusBarMessage(ref const(QString) message);
    void linkClicked(ref const(QUrl));

protected:
    /+virtual+/ void mousePressEvent(QGraphicsSceneMouseEvent*);
    /+virtual+/ void mouseDoubleClickEvent(QGraphicsSceneMouseEvent*);
    /+virtual+/ void mouseReleaseEvent(QGraphicsSceneMouseEvent*);
    /+virtual+/ void mouseMoveEvent(QGraphicsSceneMouseEvent*);
    /+virtual+/ void hoverMoveEvent(QGraphicsSceneHoverEvent*);
    /+virtual+/ void hoverLeaveEvent(QGraphicsSceneHoverEvent*);
#ifndef QT_NO_WHEELEVENT
    /+virtual+/ void wheelEvent(QGraphicsSceneWheelEvent*);
#endif
    /+virtual+/ void keyPressEvent(QKeyEvent*);
    /+virtual+/ void keyReleaseEvent(QKeyEvent*);
#ifndef QT_NO_CONTEXTMENU
    /+virtual+/ void contextMenuEvent(QGraphicsSceneContextMenuEvent*);
#endif
    /+virtual+/ void dragEnterEvent(QGraphicsSceneDragDropEvent*);
    /+virtual+/ void dragLeaveEvent(QGraphicsSceneDragDropEvent*);
    /+virtual+/ void dragMoveEvent(QGraphicsSceneDragDropEvent*);
    /+virtual+/ void dropEvent(QGraphicsSceneDragDropEvent*);
    /+virtual+/ void focusInEvent(QFocusEvent*);
    /+virtual+/ void focusOutEvent(QFocusEvent*);
    /+virtual+/ void inputMethodEvent(QInputMethodEvent*);
    /+virtual+/ bool focusNextPrevChild(bool next);

    /+virtual+/ bool sceneEvent(QEvent*);

private:
    Q_PRIVATE_SLOT(d, void _q_doLoadFinished(bool success))
    Q_PRIVATE_SLOT(d, void _q_pageDestroyed())
    Q_PRIVATE_SLOT(d, void _q_contentsSizeChanged(ref const(QSize)))
    Q_PRIVATE_SLOT(d, void _q_scaleChanged())

    QGraphicsWebViewPrivate* const d;
    friend class QGraphicsWebViewPrivate;
};

#endif // QT_NO_GRAPHICSVIEW

#endif // QGraphicsWebView_h
