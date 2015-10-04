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

#ifndef QPLAINTEXTEDIT_H
#define QPLAINTEXTEDIT_H

public import qt.QtWidgets.qtextedit;

public import qt.QtWidgets.qabstractscrollarea;
public import qt.QtGui.qtextdocument;
public import qt.QtGui.qtextoption;
public import qt.QtGui.qtextcursor;
public import qt.QtGui.qtextformat;
public import qt.QtGui.qabstracttextdocumentlayout;

#ifndef QT_NO_TEXTEDIT

QT_BEGIN_NAMESPACE


class QStyleSheet;
class QTextDocument;
class QMenu;
class QPlainTextEditPrivate;
class QMimeData;
class QPagedPaintDevice;

class Q_WIDGETS_EXPORT QPlainTextEdit : public QAbstractScrollArea
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;
    Q_ENUMS(LineWrapMode)
    mixin Q_PROPERTY!(bool, "tabChangesFocus", "READ", "tabChangesFocus", "WRITE", "setTabChangesFocus");
    mixin Q_PROPERTY!(QString, "documentTitle", "READ", "documentTitle", "WRITE", "setDocumentTitle");
    mixin Q_PROPERTY!(bool, "undoRedoEnabled", "READ", "isUndoRedoEnabled", "WRITE", "setUndoRedoEnabled");
    mixin Q_PROPERTY!(LineWrapMode, "lineWrapMode", "READ", "lineWrapMode", "WRITE", "setLineWrapMode");
    QDOC_PROPERTY(QTextOption::WrapMode wordWrapMode READ wordWrapMode WRITE setWordWrapMode)
    mixin Q_PROPERTY!(bool, "readOnly", "READ", "isReadOnly", "WRITE", "setReadOnly");
    mixin Q_PROPERTY!(QString, "plainText", "READ", "toPlainText", "WRITE", "setPlainText", "NOTIFY", "textChanged", "USER", "true");
    mixin Q_PROPERTY!(bool, "overwriteMode", "READ", "overwriteMode", "WRITE", "setOverwriteMode");
    mixin Q_PROPERTY!(int, "tabStopWidth", "READ", "tabStopWidth", "WRITE", "setTabStopWidth");
    mixin Q_PROPERTY!(int, "cursorWidth", "READ", "cursorWidth", "WRITE", "setCursorWidth");
    mixin Q_PROPERTY!(Qt.TextInteractionFlags, "textInteractionFlags", "READ", "textInteractionFlags", "WRITE", "setTextInteractionFlags");
    mixin Q_PROPERTY!(int, "blockCount", "READ", "blockCount");
    mixin Q_PROPERTY!(int, "maximumBlockCount", "READ", "maximumBlockCount", "WRITE", "setMaximumBlockCount");
    mixin Q_PROPERTY!(bool, "backgroundVisible", "READ", "backgroundVisible", "WRITE", "setBackgroundVisible");
    mixin Q_PROPERTY!(bool, "centerOnScroll", "READ", "centerOnScroll", "WRITE", "setCenterOnScroll");
    mixin Q_PROPERTY!(QString, "placeholderText", "READ", "placeholderText", "WRITE", "setPlaceholderText");
public:
    enum LineWrapMode {
        NoWrap,
        WidgetWidth
    };

    explicit QPlainTextEdit(QWidget *parent = 0);
    explicit QPlainTextEdit(ref const(QString) text, QWidget *parent = 0);
    /+virtual+/ ~QPlainTextEdit();

    void setDocument(QTextDocument *document);
    QTextDocument *document() const;

    void setPlaceholderText(ref const(QString) placeholderText);
    QString placeholderText() const;

    void setTextCursor(ref const(QTextCursor) cursor);
    QTextCursor textCursor() const;

    bool isReadOnly() const;
    void setReadOnly(bool ro);

    void setTextInteractionFlags(Qt.TextInteractionFlags flags);
    Qt.TextInteractionFlags textInteractionFlags() const;

    void mergeCurrentCharFormat(ref const(QTextCharFormat) modifier);
    void setCurrentCharFormat(ref const(QTextCharFormat) format);
    QTextCharFormat currentCharFormat() const;

    bool tabChangesFocus() const;
    void setTabChangesFocus(bool b);

    /+inline+/ void setDocumentTitle(ref const(QString) title)
    { document()->setMetaInformation(QTextDocument::DocumentTitle, title); }
    /+inline+/ QString documentTitle() const
    { return document()->metaInformation(QTextDocument::DocumentTitle); }

    /+inline+/ bool isUndoRedoEnabled() const
    { return document()->isUndoRedoEnabled(); }
    /+inline+/ void setUndoRedoEnabled(bool enable)
    { document()->setUndoRedoEnabled(enable); }

    /+inline+/ void setMaximumBlockCount(int maximum)
    { document()->setMaximumBlockCount(maximum); }
    /+inline+/ int maximumBlockCount() const
    { return document()->maximumBlockCount(); }


    LineWrapMode lineWrapMode() const;
    void setLineWrapMode(LineWrapMode mode);

    QTextOption::WrapMode wordWrapMode() const;
    void setWordWrapMode(QTextOption::WrapMode policy);

    void setBackgroundVisible(bool visible);
    bool backgroundVisible() const;

    void setCenterOnScroll(bool enabled);
    bool centerOnScroll() const;

    bool find(ref const(QString) exp, QTextDocument::FindFlags options = 0);
#ifndef QT_NO_REGEXP
    bool find(ref const(QRegExp) exp, QTextDocument::FindFlags options = 0);
#endif

    /+inline+/ QString toPlainText() const
    { return document()->toPlainText(); }

    void ensureCursorVisible();

    /+virtual+/ QVariant loadResource(int type, ref const(QUrl) name);
#ifndef QT_NO_CONTEXTMENU
    QMenu *createStandardContextMenu();
#endif

    QTextCursor cursorForPosition(ref const(QPoint) pos) const;
    QRect cursorRect(ref const(QTextCursor) cursor) const;
    QRect cursorRect() const;

    QString anchorAt(ref const(QPoint) pos) const;

    bool overwriteMode() const;
    void setOverwriteMode(bool overwrite);

    int tabStopWidth() const;
    void setTabStopWidth(int width);

    int cursorWidth() const;
    void setCursorWidth(int width);

    void setExtraSelections(ref const(QList<QTextEdit::ExtraSelection>) selections);
    QList<QTextEdit::ExtraSelection> extraSelections() const;

    void moveCursor(QTextCursor::MoveOperation operation, QTextCursor::MoveMode mode = QTextCursor::MoveAnchor);

    bool canPaste() const;

    void print(QPagedPaintDevice *printer) const;

    int blockCount() const;
    QVariant inputMethodQuery(Qt.InputMethodQuery property) const;
    Q_INVOKABLE QVariant inputMethodQuery(Qt.InputMethodQuery query, QVariant argument) const;

public Q_SLOTS:

    void setPlainText(ref const(QString) text);

#ifndef QT_NO_CLIPBOARD
    void cut();
    void copy();
    void paste();
#endif

    void undo();
    void redo();

    void clear();
    void selectAll();

    void insertPlainText(ref const(QString) text);

    void appendPlainText(ref const(QString) text);
    void appendHtml(ref const(QString) html);

    void centerCursor();

    void zoomIn(int range = 1);
    void zoomOut(int range = 1);

Q_SIGNALS:
    void textChanged();
    void undoAvailable(bool b);
    void redoAvailable(bool b);
    void copyAvailable(bool b);
    void selectionChanged();
    void cursorPositionChanged();

    void updateRequest(ref const(QRect) rect, int dy);
    void blockCountChanged(int newBlockCount);
    void modificationChanged(bool);

protected:
    /+virtual+/ bool event(QEvent *e);
    /+virtual+/ void timerEvent(QTimerEvent *e);
    /+virtual+/ void keyPressEvent(QKeyEvent *e);
    /+virtual+/ void keyReleaseEvent(QKeyEvent *e);
    /+virtual+/ void resizeEvent(QResizeEvent *e);
    /+virtual+/ void paintEvent(QPaintEvent *e);
    /+virtual+/ void mousePressEvent(QMouseEvent *e);
    /+virtual+/ void mouseMoveEvent(QMouseEvent *e);
    /+virtual+/ void mouseReleaseEvent(QMouseEvent *e);
    /+virtual+/ void mouseDoubleClickEvent(QMouseEvent *e);
    /+virtual+/ bool focusNextPrevChild(bool next);
#ifndef QT_NO_CONTEXTMENU
    /+virtual+/ void contextMenuEvent(QContextMenuEvent *e);
#endif
#ifndef QT_NO_DRAGANDDROP
    /+virtual+/ void dragEnterEvent(QDragEnterEvent *e);
    /+virtual+/ void dragLeaveEvent(QDragLeaveEvent *e);
    /+virtual+/ void dragMoveEvent(QDragMoveEvent *e);
    /+virtual+/ void dropEvent(QDropEvent *e);
#endif
    /+virtual+/ void focusInEvent(QFocusEvent *e);
    /+virtual+/ void focusOutEvent(QFocusEvent *e);
    /+virtual+/ void showEvent(QShowEvent *);
    /+virtual+/ void changeEvent(QEvent *e);
#ifndef QT_NO_WHEELEVENT
    /+virtual+/ void wheelEvent(QWheelEvent *e);
#endif

    /+virtual+/ QMimeData *createMimeDataFromSelection() const;
    /+virtual+/ bool canInsertFromMimeData(const(QMimeData)* source) const;
    /+virtual+/ void insertFromMimeData(const(QMimeData)* source);

    /+virtual+/ void inputMethodEvent(QInputMethodEvent *);

    QPlainTextEdit(QPlainTextEditPrivate &dd, QWidget *parent);

    /+virtual+/ void scrollContentsBy(int dx, int dy);
    /+virtual+/ void doSetTextCursor(ref const(QTextCursor) cursor);

    QTextBlock firstVisibleBlock() const;
    QPointF contentOffset() const;
    QRectF blockBoundingRect(ref const(QTextBlock) block) const;
    QRectF blockBoundingGeometry(ref const(QTextBlock) block) const;
    QAbstractTextDocumentLayout::PaintContext getPaintContext() const;

    void zoomInF(float range);

private:
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_repaintContents(ref const(QRectF) r))
    Q_PRIVATE_SLOT(d_func(), void _q_adjustScrollbars())
    Q_PRIVATE_SLOT(d_func(), void _q_verticalScrollbarActionTriggered(int))
    Q_PRIVATE_SLOT(d_func(), void _q_cursorPositionChanged())

    friend class QPlainTextEditControl;
};


class QPlainTextDocumentLayoutPrivate;
class Q_WIDGETS_EXPORT QPlainTextDocumentLayout : public QAbstractTextDocumentLayout
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;
    mixin Q_PROPERTY!(int, "cursorWidth", "READ", "cursorWidth", "WRITE", "setCursorWidth");

public:
    QPlainTextDocumentLayout(QTextDocument *document);
    ~QPlainTextDocumentLayout();

    void draw(QPainter *, ref const(PaintContext) );
    int hitTest(ref const(QPointF) , Qt.HitTestAccuracy ) const;

    int pageCount() const;
    QSizeF documentSize() const;

    QRectF frameBoundingRect(QTextFrame *) const;
    QRectF blockBoundingRect(ref const(QTextBlock) block) const;

    void ensureBlockLayout(ref const(QTextBlock) block) const;

    void setCursorWidth(int width);
    int cursorWidth() const;

    void requestUpdate();

protected:
    void documentChanged(int from, int /*charsRemoved*/, int charsAdded);


private:
    void setTextWidth(qreal newWidth);
    qreal textWidth() const;
    void layoutBlock(ref const(QTextBlock) block);
    qreal blockWidth(ref const(QTextBlock) block);

    QPlainTextDocumentLayoutPrivate *priv() const;

    friend class QPlainTextEdit;
    friend class QPlainTextEditPrivate;
};

QT_END_NAMESPACE


#endif // QT_NO_TEXTEDIT

#endif // QPLAINTEXTEDIT_H