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

#ifndef QFILEDIALOG_H
#define QFILEDIALOG_H

public import qt.QtCore.qdir;
public import qt.QtCore.qstring;
public import qt.QtCore.qurl;
public import qt.QtWidgets.qdialog;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_FILEDIALOG

class QModelIndex;
class QItemSelection;
struct QFileDialogArgs;
class QFileIconProvider;
class QFileDialogPrivate;
class QAbstractItemDelegate;
class QAbstractProxyModel;

class Q_WIDGETS_EXPORT QFileDialog : public QDialog
{
    mixin Q_OBJECT;
    Q_ENUMS(ViewMode FileMode AcceptMode Option)
    Q_FLAGS(Options)
    mixin Q_PROPERTY!(ViewMode, "viewMode", "READ", "viewMode", "WRITE", "setViewMode");
    mixin Q_PROPERTY!(FileMode, "fileMode", "READ", "fileMode", "WRITE", "setFileMode");
    mixin Q_PROPERTY!(AcceptMode, "acceptMode", "READ", "acceptMode", "WRITE", "setAcceptMode");
    mixin Q_PROPERTY!(bool, "readOnly", "READ", "isReadOnly", "WRITE", "setReadOnly", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(bool, "resolveSymlinks", "READ", "resolveSymlinks", "WRITE", "setResolveSymlinks", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(bool, "confirmOverwrite", "READ", "confirmOverwrite", "WRITE", "setConfirmOverwrite", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(QString, "defaultSuffix", "READ", "defaultSuffix", "WRITE", "setDefaultSuffix");
    Q_PROPERTY(bool nameFilterDetailsVisible READ isNameFilterDetailsVisible
               WRITE setNameFilterDetailsVisible DESIGNABLE false)
    mixin Q_PROPERTY!(Options, "options", "READ", "options", "WRITE", "setOptions");

public:
    enum ViewMode { Detail, List };
    enum FileMode { AnyFile, ExistingFile, Directory, ExistingFiles, DirectoryOnly };
    enum AcceptMode { AcceptOpen, AcceptSave };
    enum DialogLabel { LookIn, FileName, FileType, Accept, Reject };

    enum Option
    {
        ShowDirsOnly                = 0x00000001,
        DontResolveSymlinks         = 0x00000002,
        DontConfirmOverwrite        = 0x00000004,
        DontUseSheet                = 0x00000008,
        DontUseNativeDialog         = 0x00000010,
        ReadOnly                    = 0x00000020,
        HideNameFilterDetails       = 0x00000040,
        DontUseCustomDirectoryIcons = 0x00000080
    };
    Q_DECLARE_FLAGS(Options, Option)

    QFileDialog(QWidget *parent, Qt.WindowFlags f);
    explicit QFileDialog(QWidget *parent = 0,
                         ref const(QString) caption = QString(),
                         ref const(QString) directory = QString(),
                         ref const(QString) filter = QString());
    ~QFileDialog();

    void setDirectory(ref const(QString) directory);
    /+inline+/ void setDirectory(ref const(QDir) directory);
    QDir directory() const;

    void setDirectoryUrl(ref const(QUrl) directory);
    QUrl directoryUrl() const;

    void selectFile(ref const(QString) filename);
    QStringList selectedFiles() const;

    void selectUrl(ref const(QUrl) url);
    QList<QUrl> selectedUrls() const;

    void setNameFilterDetailsVisible(bool enabled);
    bool isNameFilterDetailsVisible() const;

    void setNameFilter(ref const(QString) filter);
    void setNameFilters(ref const(QStringList) filters);
    QStringList nameFilters() const;
    void selectNameFilter(ref const(QString) filter);
    QString selectedNameFilter() const;

    void setMimeTypeFilters(ref const(QStringList) filters);
    QStringList mimeTypeFilters() const;
    void selectMimeTypeFilter(ref const(QString) filter);

    QDir::Filters filter() const;
    void setFilter(QDir::Filters filters);

    void setViewMode(ViewMode mode);
    ViewMode viewMode() const;

    void setFileMode(FileMode mode);
    FileMode fileMode() const;

    void setAcceptMode(AcceptMode mode);
    AcceptMode acceptMode() const;

    void setReadOnly(bool enabled);
    bool isReadOnly() const;

    void setResolveSymlinks(bool enabled);
    bool resolveSymlinks() const;

    void setSidebarUrls(ref const(QList<QUrl>) urls);
    QList<QUrl> sidebarUrls() const;

    QByteArray saveState() const;
    bool restoreState(ref const(QByteArray) state);

    void setConfirmOverwrite(bool enabled);
    bool confirmOverwrite() const;

    void setDefaultSuffix(ref const(QString) suffix);
    QString defaultSuffix() const;

    void setHistory(ref const(QStringList) paths);
    QStringList history() const;

    void setItemDelegate(QAbstractItemDelegate *delegate);
    QAbstractItemDelegate *itemDelegate() const;

    void setIconProvider(QFileIconProvider *provider);
    QFileIconProvider *iconProvider() const;

    void setLabelText(DialogLabel label, ref const(QString) text);
    QString labelText(DialogLabel label) const;

#ifndef QT_NO_PROXYMODEL
    void setProxyModel(QAbstractProxyModel *model);
    QAbstractProxyModel *proxyModel() const;
#endif

    void setOption(Option option, bool on = true);
    bool testOption(Option option) const;
    void setOptions(Options options);
    Options options() const;

#ifdef Q_NO_USING_KEYWORD
#ifndef Q_QDOC
    void open() { QDialog::open(); }
#endif
#else
    using QDialog::open;
#endif
    void open(QObject *receiver, const(char)* member);
    void setVisible(bool visible);

Q_SIGNALS:
    void fileSelected(ref const(QString) file);
    void filesSelected(ref const(QStringList) files);
    void currentChanged(ref const(QString) path);
    void directoryEntered(ref const(QString) directory);

    void urlSelected(ref const(QUrl) url);
    void urlsSelected(ref const(QList<QUrl>) urls);
    void currentUrlChanged(ref const(QUrl) url);
    void directoryUrlEntered(ref const(QUrl) directory);

    void filterSelected(ref const(QString) filter);

public:

    static QString getOpenFileName(QWidget *parent = 0,
                                   ref const(QString) caption = QString(),
                                   ref const(QString) dir = QString(),
                                   ref const(QString) filter = QString(),
                                   QString *selectedFilter = 0,
                                   Options options = 0);

    static QUrl getOpenFileUrl(QWidget *parent = 0,
                               ref const(QString) caption = QString(),
                               ref const(QUrl) dir = QUrl(),
                               ref const(QString) filter = QString(),
                               QString *selectedFilter = 0,
                               Options options = 0,
                               ref const(QStringList) supportedSchemes = QStringList());

    static QString getSaveFileName(QWidget *parent = 0,
                                   ref const(QString) caption = QString(),
                                   ref const(QString) dir = QString(),
                                   ref const(QString) filter = QString(),
                                   QString *selectedFilter = 0,
                                   Options options = 0);

    static QUrl getSaveFileUrl(QWidget *parent = 0,
                               ref const(QString) caption = QString(),
                               ref const(QUrl) dir = QUrl(),
                               ref const(QString) filter = QString(),
                               QString *selectedFilter = 0,
                               Options options = 0,
                               ref const(QStringList) supportedSchemes = QStringList());

    static QString getExistingDirectory(QWidget *parent = 0,
                                        ref const(QString) caption = QString(),
                                        ref const(QString) dir = QString(),
                                        Options options = ShowDirsOnly);

    static QUrl getExistingDirectoryUrl(QWidget *parent = 0,
                                        ref const(QString) caption = QString(),
                                        ref const(QUrl) dir = QUrl(),
                                        Options options = ShowDirsOnly,
                                        ref const(QStringList) supportedSchemes = QStringList());

    static QStringList getOpenFileNames(QWidget *parent = 0,
                                        ref const(QString) caption = QString(),
                                        ref const(QString) dir = QString(),
                                        ref const(QString) filter = QString(),
                                        QString *selectedFilter = 0,
                                        Options options = 0);

    static QList<QUrl> getOpenFileUrls(QWidget *parent = 0,
                                       ref const(QString) caption = QString(),
                                       ref const(QUrl) dir = QUrl(),
                                       ref const(QString) filter = QString(),
                                       QString *selectedFilter = 0,
                                       Options options = 0,
                                       ref const(QStringList) supportedSchemes = QStringList());


protected:
    QFileDialog(ref const(QFileDialogArgs) args);
    void done(int result);
    void accept();
    void changeEvent(QEvent *e);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    Q_PRIVATE_SLOT(d_func(), void _q_pathChanged(ref const(QString) ))

    Q_PRIVATE_SLOT(d_func(), void _q_navigateBackward())
    Q_PRIVATE_SLOT(d_func(), void _q_navigateForward())
    Q_PRIVATE_SLOT(d_func(), void _q_navigateToParent())
    Q_PRIVATE_SLOT(d_func(), void _q_createDirectory())
    Q_PRIVATE_SLOT(d_func(), void _q_showListView())
    Q_PRIVATE_SLOT(d_func(), void _q_showDetailsView())
    Q_PRIVATE_SLOT(d_func(), void _q_showContextMenu(ref const(QPoint) ))
    Q_PRIVATE_SLOT(d_func(), void _q_renameCurrent())
    Q_PRIVATE_SLOT(d_func(), void _q_deleteCurrent())
    Q_PRIVATE_SLOT(d_func(), void _q_showHidden())
    Q_PRIVATE_SLOT(d_func(), void _q_updateOkButton())
    Q_PRIVATE_SLOT(d_func(), void _q_currentChanged(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_enterDirectory(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitUrlSelected(ref const(QUrl) ))
    Q_PRIVATE_SLOT(d_func(), void _q_emitUrlsSelected(ref const(QList<QUrl>) ))
    Q_PRIVATE_SLOT(d_func(), void _q_nativeCurrentChanged(ref const(QUrl) ))
    Q_PRIVATE_SLOT(d_func(), void _q_nativeEnterDirectory(ref const(QUrl)))
    Q_PRIVATE_SLOT(d_func(), void _q_goToDirectory(ref const(QString) path))
    Q_PRIVATE_SLOT(d_func(), void _q_useNameFilter(int index))
    Q_PRIVATE_SLOT(d_func(), void _q_selectionChanged())
    Q_PRIVATE_SLOT(d_func(), void _q_goToUrl(ref const(QUrl) url))
    Q_PRIVATE_SLOT(d_func(), void _q_goHome())
    Q_PRIVATE_SLOT(d_func(), void _q_showHeader(QAction *))
    Q_PRIVATE_SLOT(d_func(), void _q_autoCompleteFileName(ref const(QString) text))
    Q_PRIVATE_SLOT(d_func(), void _q_rowsInserted(ref const(QModelIndex)  parent))
    Q_PRIVATE_SLOT(d_func(), void _q_fileRenamed(ref const(QString) path,
                const QString oldName, const QString newName))
    friend class QPlatformDialogHelper;
};

/+inline+/ void QFileDialog::setDirectory(ref const(QDir) adirectory)
{ setDirectory(adirectory.absolutePath()); }

Q_DECLARE_OPERATORS_FOR_FLAGS(QFileDialog::Options)

#endif // QT_NO_FILEDIALOG

QT_END_NAMESPACE

#endif // QFILEDIALOG_H
