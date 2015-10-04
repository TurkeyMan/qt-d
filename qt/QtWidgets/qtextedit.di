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

#ifndef QTEXTEDIT_H
#define QTEXTEDIT_H

public import qt.QtWidgets.qabstractscrollarea;
public import qt.QtGui.qtextdocument;
public import qt.QtGui.qtextoption;
public import qt.QtGui.qtextcursor;
public import qt.QtGui.qtextformat;

#ifndef QT_NO_TEXTEDIT


QT_BEGIN_NAMESPACE


class QStyleSheet;
class QTextDocument;
class QMenu;
class QTextEditPrivate;
class QMimeData;
class QPagedPaintDevice;

class Q_WIDGETS_EXPORT QTextEdit : public QAbstractScrollArea
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;
    Q_FLAGS(AutoFormatting)
    Q_ENUMS(LineWrapMode)
    mixin Q_PROPERTY!(AutoFormatting, "autoFormatting", "READ", "autoFormatting", "WRITE", "setAutoFormatting");
    mixin Q_PROPERTY!(bool, "tabChangesFocus", "READ", "tabChangesFocus", "WRITE", "setTabChangesFocus");
    mixin Q_PROPERTY!(QString, "documentTitle", "READ", "documentTitle", "WRITE", "setDocumentTitle");
    mixin Q_PROPERTY!(bool, "undoRedoEnabled", "READ", "isUndoRedoEnabled", "WRITE", "setUndoRedoEnabled");
    mixin Q_PROPERTY!(LineWrapMode, "lineWrapMode", "READ", "lineWrapMode", "WRITE", "setLineWrapMode");
    QDOC_PROPERTY(QTextOption::WrapMode wordWrapMode READ wordWrapMode WRITE setWordWrapMode)
    mixin Q_PROPERTY!(int, "lineWrapColumnOrWidth", "READ", "lineWrapColumnOrWidth", "WRITE", "setLineWrapColumnOrWidth");
    mixin Q_PROPERTY!(bool, "readOnly", "READ", "isReadOnly", "WRITE", "setReadOnly");
#ifndef QT_NO_TEXTHTMLPARSER
    mixin Q_PROPERTY!(QString, "html", "READ", "toHtml", "WRITE", "setHtml", "NOTIFY", "textChanged", "USER", "true");
#endif
    mixin Q_PROPERTY!(QString, "plainText", "READ", "toPlainText", "WRITE", "setPlainText", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(bool, "overwriteMode", "READ", "overwriteMode", "WRITE", "setOverwriteMode");
    mixin Q_PROPERTY!(int, "tabStopWidth", "READ", "tabStopWidth", "WRITE", "setTabStopWidth");
    mixin Q_PROPERTY!(bool, "acceptRichText", "READ", "acceptRichText", "WRITE", "setAcceptRichText");
    mixin Q_PROPERTY!(int, "cursorWidth", "READ", "cursorWidth", "WRITE", "setCursorWidth");
    mixin Q_PROPERTY!(Qt.TextInteractionFlags, "textInteractionFlags", "READ", "textInteractionFlags", "WRITE", "setTextInteractionFlags");
    mixin Q_PROPERTY!(QTextDocument, "*document", "READ", "document", "WRITE", "setDocument", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(QString, "placeholderText", "READ", "placeholderText", "WRITE", "setPlaceholderText");
public:
    enum LineWrapMode {
        NoWrap,
        WidgetWidth,
        FixedPixelWidth,
        FixedColumnWidth
    };

    enum AutoFormattingFlag {
        AutoNone = 0,
        AutoBulletList = 0x00000001,
        AutoAll = 0xffffffff
    };

    Q_DECLARE_FLAGS(AutoFormatting, AutoFormattingFlag)

    explicit QTextEdit(QWidget *parent = 0);
    explicit QTextEdit(ref const(QString) text, QWidget *parent = 0);
    /+virtual+/ ~QTextEdit();

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

    qreal fontPointSize() const;
    QString fontFamily() const;
    int fontWeight() const;
    bool fontUnderline() const;
    bool fontItalic() const;
    QColor textColor() const;
    QColor textBackgroundColor() const;
    QFont currentFont() const;
    Qt.Alignment alignment() const;

    void mergeCurrentCharFormat(ref const(QTextCharFormat) modifier);

    void setCurrentCharFormat(ref const(QTextCharFormat) format);
    QTextCharFormat currentCharFormat() const;

    AutoFormatting autoFormatting() const;
    void setAutoFormatting(AutoFormatting features);

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

    LineWrapMode lineWrapMode() const;
    void setLineWrapMode(LineWrapMode mode);

    int lineWrapColumnOrWidth() const;
    void setLineWrapColumnOrWidth(int w);

    QTextOption::WrapMode wordWrapMode() const;
    void setWordWrapMode(QTextOption::WrapMode policy);

    bool find(ref const(QString) exp, QTextDocument::FindFlags options = 0);
#ifndef QT_NO_REGEXP
    bool find(ref const(QRegExp) exp, QTextDocument::FindFlags options = 0);
#endif

    QString toPlainText() const;
#ifndef QT_NO_TEXTHTMLPARSER
    QString toHtml() const;
#endif

    void ensureCursorVisible();

    Q_INVOKABLE /+virtual+/ QVariant loadResource(int type, ref const(QUrl) name);
#ifndef QT_NO_CONTEXTMENU
    QMenu *createStandardContextMenu();
    QMenu *createStandardContextMenu(ref const(QPoint) position);
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

    bool acceptRichText() const;
    void setAcceptRichText(bool accept);

    struct ExtraSelection
    {
        QTextCursor cursor;
        QTextCharFormat format;
    };
    void setExtraSelections(ref const(QList<ExtraSelection>) selections);
    QList<ExtraSelection> extraSelections() const;

    void moveCursor(QTextCursor::MoveOperation operation, QTextCursor::MoveMode mode = QTextCursor::MoveAnchor);

    bool canPaste() const;

    void print(QPagedPaintDevice *printer) const;

    QVariant inputMethodQuery(Qt.InputMethodQuery property) const;
    Q_INVOKABLE QVariant inputMethodQuery(Qt.InputMethodQuery query, QVariant argument) const;

public Q_SLOTS:
    void setFontPointSize(qreal s);
    void setFontFamily(ref const(QString) fontFamily);
    void setFontWeight(int w);
    void setFontUnderline(bool b);
    void setFontItalic(bool b);
    void setTextColor(ref const(QColor) c);
    void setTextBackgroundColor(ref const(QColor) c);
    void setCurrentFont(ref const(QFont) f);
    void setAlignment(Qt.Alignment a);

    void setPlainText(ref const(QString) text);
#ifndef QT_NO_TEXTHTMLPARSER
    void setHtml(ref const(QString) text);
#endif
    void setText(ref const(QString) text);

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
#ifndef QT_NO_TEXTHTMLPARSER
    void insertHtml(ref const(QString) text);
#endif // QT_NO_TEXTHTMLPARSER

    void append(ref const(QString) text);

    void scrollToAnchor(ref const(QString) name);

    void zoomIn(int range = 1);
    void zoomOut(int range = 1);

Q_SIGNALS:
    void textChanged();
    void undoAvailable(bool b);
    void redoAvailable(bool b);
    void currentCharFormatChanged(ref const(QTextCharFormat) format);
    void copyAvailable(bool b);
    void selectionChanged();
    void cursorPositionChanged();

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

    QTextEdit(QTextEditPrivate &dd, QWidget *parent);

    /+virtual+/ void scrollContentsBy(int dx, int dy);
    /+virtual+/ void doSetTextCursor(ref const(QTextCursor) cursor);

    void zoomInF(float range);

private:
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_repaintContents(ref const(QRectF) r))
    Q_PRIVATE_SLOT(d_func(), void _q_currentCharFormatChanged(ref const(QTextCharFormat) ))
    Q_PRIVATE_SLOT(d_func(), void _q_adjustScrollbars())
    Q_PRIVATE_SLOT(d_func(), void _q_ensureVisible(ref const(QRectF) ))
    Q_PRIVATE_SLOT(d_func(), void _q_cursorPositionChanged())
    friend class QTextEditControl;
    friend class QTextDocument;
    friend class QWidgetTextControl;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QTextEdit::AutoFormatting)

QT_END_NAMESPACE

#endif // QT_NO_TEXTEDIT

#endif // QTEXTEDIT_H
