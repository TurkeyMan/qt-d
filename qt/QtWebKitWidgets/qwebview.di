/*
    Copyright (C) 2008 Nokia Corporation and/or its subsidiary(-ies)
    Copyright (C) 2007 Staikos Computing Services Inc.

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

#ifndef QWEBVIEW_H
#define QWEBVIEW_H

public import qt.QtWebKit.qwebkitglobal;
public import qt.QtWebKitWidgets.qwebpage;
public import qt.QtCore.qurl;
public import qt.QtGui.qicon;
public import qt.QtGui.qpainter;
public import qt.QtNetwork.qnetworkaccessmanager;
public import qt.QtWidgets.qwidget;

QT_BEGIN_NAMESPACE
class QNetworkRequest;
class QPrinter;
QT_END_NAMESPACE

class QWebPage;
class QWebViewPrivate;
class QWebNetworkRequest;

class QWEBKITWIDGETS_EXPORT QWebView : public QWidget {
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QString, "title", "READ", "title");
    mixin Q_PROPERTY!(QUrl, "url", "READ", "url", "WRITE", "setUrl");
    mixin Q_PROPERTY!(QIcon, "icon", "READ", "icon");
    mixin Q_PROPERTY!(QString, "selectedText", "READ", "selectedText");
    mixin Q_PROPERTY!(QString, "selectedHtml", "READ", "selectedHtml");
    mixin Q_PROPERTY!(bool, "hasSelection", "READ", "hasSelection");
    mixin Q_PROPERTY!(bool, "modified", "READ", "isModified");
    //mixin Q_PROPERTY!(Qt.TextInteractionFlags, "textInteractionFlags", "READ", "textInteractionFlags", "WRITE", "setTextInteractionFlags");
    mixin Q_PROPERTY!(qreal, "textSizeMultiplier", "READ", "textSizeMultiplier", "WRITE", "setTextSizeMultiplier", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(qreal, "zoomFactor", "READ", "zoomFactor", "WRITE", "setZoomFactor");

    mixin Q_PROPERTY!(QPainter::RenderHints, "renderHints", "READ", "renderHints", "WRITE", "setRenderHints");
    Q_FLAGS(QPainter::RenderHints)
public:
    explicit QWebView(QWidget* parent = 0);
    /+virtual+/ ~QWebView();

    QWebPage* page() const;
    void setPage(QWebPage* page);

    void load(ref const(QUrl) url);
    void load(ref const(QNetworkRequest) request, QNetworkAccessManager::Operation operation = QNetworkAccessManager::GetOperation, ref const(QByteArray) body = QByteArray());
    void setHtml(ref const(QString) html, ref const(QUrl) baseUrl = QUrl());
    void setContent(ref const(QByteArray) data, ref const(QString) mimeType = QString(), ref const(QUrl) baseUrl = QUrl());

    QWebHistory* history() const;
    QWebSettings* settings() const;

    QString title() const;
    void setUrl(ref const(QUrl) url);
    QUrl url() const;
    QIcon icon() const;

    bool hasSelection() const;
    QString selectedText() const;
    QString selectedHtml() const;

#ifndef QT_NO_ACTION
    QAction* pageAction(QWebPage::WebAction action) const;
#endif
    void triggerPageAction(QWebPage::WebAction action, bool checked = false);

    bool isModified() const;

    /*
    Qt.TextInteractionFlags textInteractionFlags() const;
    void setTextInteractionFlags(Qt.TextInteractionFlags flags);
    void setTextInteractionFlag(Qt.TextInteractionFlag flag);
    */

    QVariant inputMethodQuery(Qt.InputMethodQuery property) const;

    QSize sizeHint() const;

    qreal zoomFactor() const;
    void setZoomFactor(qreal factor);

    void setTextSizeMultiplier(qreal factor);
    qreal textSizeMultiplier() const;

    QPainter::RenderHints renderHints() const;
    void setRenderHints(QPainter::RenderHints hints);
    void setRenderHint(QPainter::RenderHint hint, bool enabled = true);

    bool findText(ref const(QString) subString, QWebPage::FindFlags options = 0);

    /+virtual+/ bool event(QEvent*);

public Q_SLOTS:
    void stop();
    void back();
    void forward();
    void reload();

    void print(QPrinter*) const;

Q_SIGNALS:
    void loadStarted();
    void loadProgress(int progress);
    void loadFinished(bool);
    void titleChanged(ref const(QString) title);
    void statusBarMessage(ref const(QString) text);
    void linkClicked(ref const(QUrl));
    void selectionChanged();
    void iconChanged();
    void urlChanged(ref const(QUrl));

protected:
    void resizeEvent(QResizeEvent*);
    void paintEvent(QPaintEvent*);

    /+virtual+/ QWebView *createWindow(QWebPage::WebWindowType type);

    /+virtual+/ void changeEvent(QEvent*);
    /+virtual+/ void mouseMoveEvent(QMouseEvent*);
    /+virtual+/ void mousePressEvent(QMouseEvent*);
    /+virtual+/ void mouseDoubleClickEvent(QMouseEvent*);
    /+virtual+/ void mouseReleaseEvent(QMouseEvent*);
#ifndef QT_NO_CONTEXTMENU
    /+virtual+/ void contextMenuEvent(QContextMenuEvent*);
#endif
#ifndef QT_NO_WHEELEVENT
    /+virtual+/ void wheelEvent(QWheelEvent*);
#endif
    /+virtual+/ void keyPressEvent(QKeyEvent*);
    /+virtual+/ void keyReleaseEvent(QKeyEvent*);
    /+virtual+/ void dragEnterEvent(QDragEnterEvent*);
    /+virtual+/ void dragLeaveEvent(QDragLeaveEvent*);
    /+virtual+/ void dragMoveEvent(QDragMoveEvent*);
    /+virtual+/ void dropEvent(QDropEvent*);
    /+virtual+/ void focusInEvent(QFocusEvent*);
    /+virtual+/ void focusOutEvent(QFocusEvent*);
    /+virtual+/ void inputMethodEvent(QInputMethodEvent*);

    /+virtual+/ bool focusNextPrevChild(bool next);

private:
    friend class QWebPage;
    QWebViewPrivate* d;
    Q_PRIVATE_SLOT(d, void _q_pageDestroyed())
};

#endif // QWEBVIEW_H
