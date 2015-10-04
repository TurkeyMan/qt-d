/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Copyright (C) 2013 Olivier Goffart <ogoffart@woboq.com>
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtCore module of the Qt Toolkit.
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

version(QT_NO_QOBJECT) {} else {

public import QtCore.qobjectdefs;
public import QtCore.qstring;
public import QtCore.qbytearray;
public import QtCore.qlist;
version(QT_INCLUDE_COMPAT)
    public import QtCore.qcoreevent;
public import QtCore.qscopedpointer;
public import QtCore.qmetatype;

public import QtCore.qobject_impl;


extern(C++) class QEvent;
extern(C++) class QTimerEvent;
extern(C++) class QChildEvent;
extern(C++) struct QMetaObject;
extern(C++) class QVariant;
extern(C++) class QObjectPrivate;
extern(C++) class QObject;
extern(C++) class QThread;
extern(C++) class QWidget;
version(QT_NO_REGEXP) {} else
    extern(C++) class QRegExp;
version(QT_NO_REGULAREXPRESSION) {} else
    extern(C++) class QRegularExpression;
version(QT_NO_USERDATA) {} else
    extern(C++) class QObjectUserData;
struct QDynamicMetaObjectData;

alias QObjectList = QList!(QObject*);

export void qt_qFindChildren_helper(const(QObject)* parent, ref const QString name,
                                           ref const QMetaObject mo, QList!(void*)* list, Qt.FindChildOptions options);
export void qt_qFindChildren_helper(const(QObject)* parent, ref const QRegExp re,
                                           ref const QMetaObject mo, QList!(void*)* list, Qt.FindChildOptions options);
export void qt_qFindChildren_helper(const(QObject)* parent, ref const QRegularExpression re,
                                           ref const QMetaObject mo, QList!(void*)* list, Qt.FindChildOptions options);
export QObject *qt_qFindChild_helper(const(QObject)* parent, ref const QString name, ref const QMetaObject mo, Qt.FindChildOptions options);

export extern(C++) class QObjectData {
public:
    abstract ~this();
    QObject* q_ptr;
    QObject* parent;
    QObjectList children;

    uint isWidget : 1;
    uint blockSig : 1;
    uint wasDeleted : 1;
    uint isDeletingChildren : 1;
    uint sendChildEvents : 1;
    uint receiveChildEvents : 1;
    uint isWindow : 1; //for QWindow
    uint unused : 25;
    int postedEvents;
    QDynamicMetaObjectData* metaObject;
    QMetaObject* dynamicMetaObject() const;
}


export extern(C++) class QObject
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QString, "objectName", "READ", "objectName", "WRITE", "setObjectName", "NOTIFY", "objectNameChanged");
    mixin Q_DECLARE_PRIVATE;

public:
    Q_INVOKABLE explicit QObject(QObject *parent=0);
    /+virtual+/ ~QObject();

    /+virtual+/ bool event(QEvent *);
    /+virtual+/ bool eventFilter(QObject *, QEvent *);

#ifdef Q_QDOC
    static QString tr(const(char)* sourceText, const(char)* comment = 0, int n = -1);
    static QString trUtf8(const(char)* sourceText, const(char)* comment = 0, int n = -1);
    /+virtual+/ const(QMetaObject)* metaObject() const;
    static const QMetaObject staticMetaObject;
#endif
#ifdef QT_NO_TRANSLATION
    static QString tr(const(char)* sourceText, const(char)*  = 0, int = -1)
        { return QString::fromUtf8(sourceText); }
#if QT_DEPRECATED_SINCE(5, 0)
    QT_DEPRECATED static QString trUtf8(const(char)* sourceText, const(char)*  = 0, int = -1)
        { return QString::fromUtf8(sourceText); }
#endif
#endif //QT_NO_TRANSLATION

    QString objectName() const;
    void setObjectName(ref const(QString) name);

    /+inline+/ bool isWidgetType() const { return d_ptr->isWidget; }
    /+inline+/ bool isWindowType() const { return d_ptr->isWindow; }

    /+inline+/ bool signalsBlocked() const { return d_ptr->blockSig; }
    bool blockSignals(bool b);

    QThread *thread() const;
    void moveToThread(QThread *thread);

    int startTimer(int interval, Qt.TimerType timerType = Qt.CoarseTimer);
    void killTimer(int id);

    template<typename T>
    /+inline+/ T findChild(ref const(QString) aName = QString(), Qt.FindChildOptions options = Qt.FindChildrenRecursively) const
    {
        typedef typename QtPrivate::remove_cv<typename QtPrivate::remove_pointer<T>::type>::type ObjType;
        return static_cast<T>(qt_qFindChild_helper(this, aName, ObjType::staticMetaObject, options));
    }

    template<typename T>
    /+inline+/ QList<T> findChildren(ref const(QString) aName = QString(), Qt.FindChildOptions options = Qt.FindChildrenRecursively) const
    {
        typedef typename QtPrivate::remove_cv<typename QtPrivate::remove_pointer<T>::type>::type ObjType;
        QList<T> list;
        qt_qFindChildren_helper(this, aName, ObjType::staticMetaObject,
                                reinterpret_cast<QList<void *> *>(&list), options);
        return list;
    }

#ifndef QT_NO_REGEXP
    template<typename T>
    /+inline+/ QList<T> findChildren(ref const(QRegExp) re, Qt.FindChildOptions options = Qt.FindChildrenRecursively) const
    {
        typedef typename QtPrivate::remove_cv<typename QtPrivate::remove_pointer<T>::type>::type ObjType;
        QList<T> list;
        qt_qFindChildren_helper(this, re, ObjType::staticMetaObject,
                                reinterpret_cast<QList<void *> *>(&list), options);
        return list;
    }
#endif

#ifndef QT_NO_REGULAREXPRESSION
    template<typename T>
    /+inline+/ QList<T> findChildren(ref const(QRegularExpression) re, Qt.FindChildOptions options = Qt.FindChildrenRecursively) const
    {
        typedef typename QtPrivate::remove_cv<typename QtPrivate::remove_pointer<T>::type>::type ObjType;
        QList<T> list;
        qt_qFindChildren_helper(this, re, ObjType::staticMetaObject,
                                reinterpret_cast<QList<void *> *>(&list), options);
        return list;
    }
#endif

    /+inline+/ ref const(QObjectList) children() const { return d_ptr->children; }

    void setParent(QObject *);
    void installEventFilter(QObject *);
    void removeEventFilter(QObject *);

    static QMetaObject::Connection connect(const(QObject)* sender, const(char)* signal,
                        const(QObject)* receiver, const(char)* member, Qt.ConnectionType = Qt.AutoConnection);

    static QMetaObject::Connection connect(const(QObject)* sender, ref const(QMetaMethod) signal,
                        const(QObject)* receiver, ref const(QMetaMethod) method,
                        Qt.ConnectionType type = Qt.AutoConnection);

    /+inline+/ QMetaObject::Connection connect(const(QObject)* sender, const(char)* signal,
                        const(char)* member, Qt.ConnectionType type = Qt.AutoConnection) const;

#ifdef Q_QDOC
    static QMetaObject::Connection connect(const(QObject)* sender, PointerToMemberFunction signal, const(QObject)* receiver, PointerToMemberFunction method, Qt.ConnectionType type = Qt.AutoConnection);
    static QMetaObject::Connection connect(const(QObject)* sender, PointerToMemberFunction signal, Functor functor);
    static QMetaObject::Connection connect(const(QObject)* sender, PointerToMemberFunction signal, const(QObject)* context, Functor functor, Qt.ConnectionType type = Qt.AutoConnection);
#else
    //Connect a signal to a pointer to qobject member function
    template <typename Func1, typename Func2>
    static /+inline+/ QMetaObject::Connection connect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal,
                                     const typename QtPrivate::FunctionPointer<Func2>::Object *receiver, Func2 slot,
                                     Qt.ConnectionType type = Qt.AutoConnection)
    {
        typedef QtPrivate::FunctionPointer<Func1> SignalType;
        typedef QtPrivate::FunctionPointer<Func2> SlotType;

        Q_STATIC_ASSERT_X(QtPrivate::Hasmixin Q_OBJECT;_Macro<typename SignalType::Object>::Value,
                          "No mixin Q_OBJECT; in the extern(C++) class with the signal");

        //compilation error if the arguments does not match.
        Q_STATIC_ASSERT_X(int(SignalType::ArgumentCount) >= int(SlotType::ArgumentCount),
                          "The slot requires more arguments than the signal provides.");
        Q_STATIC_ASSERT_X((QtPrivate::CheckCompatibleArguments<typename SignalType::Arguments, typename SlotType::Arguments>::value),
                          "Signal and slot arguments are not compatible.");
        Q_STATIC_ASSERT_X((QtPrivate::AreArgumentsCompatible<typename SlotType::ReturnType, typename SignalType::ReturnType>::value),
                          "Return type of the slot is not compatible with the return type of the signal.");

        const(int)* types = 0;
        if (type == Qt.QueuedConnection || type == Qt.BlockingQueuedConnection)
            types = QtPrivate::ConnectionTypes<typename SignalType::Arguments>::types();

        return connectImpl(sender, reinterpret_cast<void **>(&signal),
                           receiver, reinterpret_cast<void **>(&slot),
                           new QtPrivate::QSlotObject<Func2, typename QtPrivate::List_Left<typename SignalType::Arguments, SlotType::ArgumentCount>::Value,
                                           typename SignalType::ReturnType>(slot),
                            type, types, &SignalType::Object::staticMetaObject);
    }

    //connect to a function pointer  (not a member)
    template <typename Func1, typename Func2>
    static /+inline+/ typename QtPrivate::QEnableIf<int(QtPrivate::FunctionPointer<Func2>::ArgumentCount) >= 0, QMetaObject::Connection>::Type
            connect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal, Func2 slot)
    {
        return connect(sender, signal, sender, slot, Qt.DirectConnection);
    }

    //connect to a function pointer  (not a member)
    template <typename Func1, typename Func2>
    static /+inline+/ typename QtPrivate::QEnableIf<int(QtPrivate::FunctionPointer<Func2>::ArgumentCount) >= 0 &&
                                                !QtPrivate::FunctionPointer<Func2>::IsPointerToMemberFunction, QMetaObject::Connection>::Type
            connect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal, const(QObject)* context, Func2 slot,
                    Qt.ConnectionType type = Qt.AutoConnection)
    {
        typedef QtPrivate::FunctionPointer<Func1> SignalType;
        typedef QtPrivate::FunctionPointer<Func2> SlotType;

        Q_STATIC_ASSERT_X(QtPrivate::Hasmixin Q_OBJECT;_Macro<typename SignalType::Object>::Value,
                          "No mixin Q_OBJECT; in the extern(C++) class with the signal");

        //compilation error if the arguments does not match.
        Q_STATIC_ASSERT_X(int(SignalType::ArgumentCount) >= int(SlotType::ArgumentCount),
                          "The slot requires more arguments than the signal provides.");
        Q_STATIC_ASSERT_X((QtPrivate::CheckCompatibleArguments<typename SignalType::Arguments, typename SlotType::Arguments>::value),
                          "Signal and slot arguments are not compatible.");
        Q_STATIC_ASSERT_X((QtPrivate::AreArgumentsCompatible<typename SlotType::ReturnType, typename SignalType::ReturnType>::value),
                          "Return type of the slot is not compatible with the return type of the signal.");

        const(int)* types = 0;
        if (type == Qt.QueuedConnection || type == Qt.BlockingQueuedConnection)
            types = QtPrivate::ConnectionTypes<typename SignalType::Arguments>::types();

        return connectImpl(sender, reinterpret_cast<void **>(&signal), context, 0,
                           new QtPrivate::QStaticSlotObject<Func2,
                                                 typename QtPrivate::List_Left<typename SignalType::Arguments, SlotType::ArgumentCount>::Value,
                                                 typename SignalType::ReturnType>(slot),
                           type, types, &SignalType::Object::staticMetaObject);
    }

    //connect to a functor
    template <typename Func1, typename Func2>
    static /+inline+/ typename QtPrivate::QEnableIf<QtPrivate::FunctionPointer<Func2>::ArgumentCount == -1, QMetaObject::Connection>::Type
            connect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal, Func2 slot)
    {
        return connect(sender, signal, sender, slot, Qt.DirectConnection);
    }

    //connect to a functor, with a "context" object defining in which event loop is going to be executed
    template <typename Func1, typename Func2>
    static /+inline+/ typename QtPrivate::QEnableIf<QtPrivate::FunctionPointer<Func2>::ArgumentCount == -1, QMetaObject::Connection>::Type
            connect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal, const(QObject)* context, Func2 slot,
                    Qt.ConnectionType type = Qt.AutoConnection)
    {
#if defined (Q_COMPILER_DECLTYPE) && defined (Q_COMPILER_VARIADIC_TEMPLATES)
        typedef QtPrivate::FunctionPointer<Func1> SignalType;
        const int FunctorArgumentCount = QtPrivate::ComputeFunctorArgumentCount<Func2 , typename SignalType::Arguments>::Value;

        Q_STATIC_ASSERT_X((FunctorArgumentCount >= 0),
                          "Signal and slot arguments are not compatible.");
        const int SlotArgumentCount = (FunctorArgumentCount >= 0) ? FunctorArgumentCount : 0;
        typedef typename QtPrivate::FunctorReturnType<Func2, typename QtPrivate::List_Left<typename SignalType::Arguments, SlotArgumentCount>::Value>::Value SlotReturnType;
#else
      // Without variadic template, we don't detect the best overload of operator(). We just
      // assume there is only one simple operator() and connect to &Func2::operator()

      /* If you get an error such as:
             couldn't deduce template parameter 'Func2Operator'
        or
             cannot resolve address of overloaded function
        It means the functor does not have a single operator().
        Functors with overloaded or templated operator() are only supported if the compiler supports
        C++11 variadic templates
      */
#ifndef Q_COMPILER_DECLTYPE  //Workaround the lack of decltype using another function as indirection
        return connect_functor(sender, signal, context, slot, &Func2::operator(), type); }
    template <typename Func1, typename Func2, typename Func2Operator>
    static /+inline+/ QMetaObject::Connection connect_functor(const(QObject)* sender, Func1 signal, const(QObject)* context,
                                                          Func2 slot, Func2Operator, Qt.ConnectionType type) {
        typedef QtPrivate::FunctionPointer<Func2Operator> SlotType ;
#else
        typedef QtPrivate::FunctionPointer<decltype(&Func2::operator())> SlotType ;
#endif
        typedef QtPrivate::FunctionPointer<Func1> SignalType;
        typedef typename SlotType::ReturnType SlotReturnType;
        const int SlotArgumentCount = SlotType::ArgumentCount;

        Q_STATIC_ASSERT_X(int(SignalType::ArgumentCount) >= SlotArgumentCount,
                          "The slot requires more arguments than the signal provides.");
        Q_STATIC_ASSERT_X((QtPrivate::CheckCompatibleArguments<typename SignalType::Arguments, typename SlotType::Arguments>::value),
                          "Signal and slot arguments are not compatible.");
#endif

        Q_STATIC_ASSERT_X((QtPrivate::AreArgumentsCompatible<SlotReturnType, typename SignalType::ReturnType>::value),
                          "Return type of the slot is not compatible with the return type of the signal.");

        Q_STATIC_ASSERT_X(QtPrivate::Hasmixin Q_OBJECT;_Macro<typename SignalType::Object>::Value,
                          "No mixin Q_OBJECT; in the extern(C++) class with the signal");

        const(int)* types = 0;
        if (type == Qt.QueuedConnection || type == Qt.BlockingQueuedConnection)
            types = QtPrivate::ConnectionTypes<typename SignalType::Arguments>::types();

        return connectImpl(sender, reinterpret_cast<void **>(&signal), context, 0,
                           new QtPrivate::QFunctorSlotObject<Func2, SlotArgumentCount,
                                typename QtPrivate::List_Left<typename SignalType::Arguments, SlotArgumentCount>::Value,
                                typename SignalType::ReturnType>(slot),
                           type, types, &SignalType::Object::staticMetaObject);
    }
#endif //Q_QDOC

    static bool disconnect(const(QObject)* sender, const(char)* signal,
                           const(QObject)* receiver, const(char)* member);
    static bool disconnect(const(QObject)* sender, ref const(QMetaMethod) signal,
                           const(QObject)* receiver, ref const(QMetaMethod) member);
    /+inline+/ bool disconnect(const(char)* signal = 0,
                           const(QObject)* receiver = 0, const(char)* member = 0) const
        { return disconnect(this, signal, receiver, member); }
    /+inline+/ bool disconnect(const(QObject)* receiver, const(char)* member = 0) const
        { return disconnect(this, 0, receiver, member); }
    static bool disconnect(ref const(QMetaObject::Connection) );

#ifdef Q_QDOC
    static bool disconnect(const(QObject)* sender, PointerToMemberFunction signal, const(QObject)* receiver, PointerToMemberFunction method);
#else
    template <typename Func1, typename Func2>
    static /+inline+/ bool disconnect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal,
                                  const typename QtPrivate::FunctionPointer<Func2>::Object *receiver, Func2 slot)
    {
        typedef QtPrivate::FunctionPointer<Func1> SignalType;
        typedef QtPrivate::FunctionPointer<Func2> SlotType;

        Q_STATIC_ASSERT_X(QtPrivate::Hasmixin Q_OBJECT;_Macro<typename SignalType::Object>::Value,
                          "No mixin Q_OBJECT; in the extern(C++) class with the signal");

        //compilation error if the arguments does not match.
        Q_STATIC_ASSERT_X((QtPrivate::CheckCompatibleArguments<typename SignalType::Arguments, typename SlotType::Arguments>::value),
                          "Signal and slot arguments are not compatible.");

        return disconnectImpl(sender, reinterpret_cast<void **>(&signal), receiver, reinterpret_cast<void **>(&slot),
                              &SignalType::Object::staticMetaObject);
    }
    template <typename Func1>
    static /+inline+/ bool disconnect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal,
                                  const(QObject)* receiver, void **zero)
    {
        // This is the overload for when one wish to disconnect a signal from any slot. (slot=0)
        // Since the function template parameter cannot be deduced from '0', we use a
        // dummy void ** parameter that must be equal to 0
        Q_ASSERT(!zero);
        typedef QtPrivate::FunctionPointer<Func1> SignalType;
        return disconnectImpl(sender, reinterpret_cast<void **>(&signal), receiver, zero,
                              &SignalType::Object::staticMetaObject);
    }
#endif //Q_QDOC


    void dumpObjectTree();
    void dumpObjectInfo();

#ifndef QT_NO_PROPERTIES
    bool setProperty(const(char)* name, ref const(QVariant) value);
    QVariant property(const(char)* name) const;
    QList<QByteArray> dynamicPropertyNames() const;
#endif // QT_NO_PROPERTIES

#ifndef QT_NO_USERDATA
    static uint registerUserData();
    void setUserData(uint id, QObjectUserData* data);
    QObjectUserData* userData(uint id) const;
#endif // QT_NO_USERDATA

Q_SIGNALS:
    void destroyed(QObject * = 0);
    void objectNameChanged(ref const(QString) objectName
#if !defined(Q_QDOC)
    , QPrivateSignal
#endif
    );

public:
    /+inline+/ QObject *parent() const { return d_ptr->parent; }

    /+inline+/ bool inherits(const(char)* classname) const
        { return const_cast<QObject *>(this)->qt_metacast(classname) != 0; }

public Q_SLOTS:
    void deleteLater();

protected:
    QObject *sender() const;
    int senderSignalIndex() const;
    int receivers(const(char)* signal) const;
    bool isSignalConnected(ref const(QMetaMethod) signal) const;

    /+virtual+/ void timerEvent(QTimerEvent *);
    /+virtual+/ void childEvent(QChildEvent *);
    /+virtual+/ void customEvent(QEvent *);

    /+virtual+/ void connectNotify(ref const(QMetaMethod) signal);
    /+virtual+/ void disconnectNotify(ref const(QMetaMethod) signal);

protected:
    QObject(QObjectPrivate &dd, QObject *parent = 0);

protected:
    QScopedPointer<QObjectData> d_ptr;

    static const QMetaObject staticQtMetaObject;

    friend struct QMetaObject;
    friend struct QMetaObjectPrivate;
    friend extern(C++) class QMetaCallEvent;
    friend extern(C++) class QApplication;
    friend extern(C++) class QApplicationPrivate;
    friend extern(C++) class QCoreApplication;
    friend extern(C++) class QCoreApplicationPrivate;
    friend extern(C++) class QWidget;
    friend extern(C++) class QThreadData;

private:
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_reregisterTimers(void *))

private:
    static QMetaObject::Connection connectImpl(const(QObject)* sender, void **signal,
                                               const(QObject)* receiver, void **slotPtr,
                                               QtPrivate::QSlotObjectBase *slot, Qt.ConnectionType type,
                                               const(int)* types, const(QMetaObject)* senderMetaObject);

    static bool disconnectImpl(const(QObject)* sender, void **signal, const(QObject)* receiver, void **slot,
                               const(QMetaObject)* senderMetaObject);

}

/+inline+/ QMetaObject::Connection QObject::connect(const(QObject)* asender, const(char)* asignal,
                                            const(char)* amember, Qt.ConnectionType atype) const
{ return connect(asender, asignal, this, amember, atype); }

#ifndef QT_NO_USERDATA
extern(C++) class export QObjectUserData {
public:
    /+virtual+/ ~QObjectUserData();
}
#endif

#ifdef Q_QDOC
T qFindChild(const(QObject)* o, ref const(QString) name = QString());
QList<T> qFindChildren(const(QObject)* oobj, ref const(QString) name = QString());
QList<T> qFindChildren(const(QObject)* o, ref const(QRegExp) re);
#endif
#if QT_DEPRECATED_SINCE(5, 0)
template<typename T>
/+inline+/ QT_DEPRECATED T qFindChild(const(QObject)* o, ref const(QString) name = QString())
{ return o->findChild<T>(name); }

template<typename T>
/+inline+/ QT_DEPRECATED QList<T> qFindChildren(const(QObject)* o, ref const(QString) name = QString())
{
    return o->findChildren<T>(name);
}

#ifndef QT_NO_REGEXP
template<typename T>
/+inline+/ QT_DEPRECATED QList<T> qFindChildren(const(QObject)* o, ref const(QRegExp) re)
{
    return o->findChildren<T>(re);
}
#endif

#endif //QT_DEPRECATED

template <class T>
/+inline+/ T qobject_cast(QObject *object)
{
    typedef typename QtPrivate::remove_cv<typename QtPrivate::remove_pointer<T>::type>::type ObjType;
    Q_STATIC_ASSERT_X(QtPrivate::Hasmixin Q_OBJECT;_Macro<ObjType>::Value,
                    "qobject_cast requires the type to have a mixin Q_OBJECT; macro");
    return static_cast<T>(ObjType::staticMetaObject.cast(object));
}

template <class T>
/+inline+/ T qobject_cast(const(QObject)* object)
{
    typedef typename QtPrivate::remove_cv<typename QtPrivate::remove_pointer<T>::type>::type ObjType;
    Q_STATIC_ASSERT_X(QtPrivate::Hasmixin Q_OBJECT;_Macro<ObjType>::Value,
                      "qobject_cast requires the type to have a mixin Q_OBJECT; macro");
    return static_cast<T>(ObjType::staticMetaObject.cast(object));
}


template <class T> /+inline+/ const(char)*  qobject_interface_iid()
{ return 0; }

#ifndef Q_MOC_RUN
#  define Q_DECLARE_INTERFACE(IFace, IId) \
    template <> /+inline+/ const(char)* qobject_interface_iid<IFace *>() \
    { return IId; } \
    template <> /+inline+/ IFace *qobject_cast<IFace *>(QObject *object) \
    { return reinterpret_cast<IFace *>((object ? object->qt_metacast(IId) : 0)); } \
    template <> /+inline+/ IFace *qobject_cast<IFace *>(const(QObject)* object) \
    { return reinterpret_cast<IFace *>((object ? const_cast<QObject *>(object)->qt_metacast(IId) : 0)); }
#endif // Q_MOC_RUN

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, const(QObject)* );
#endif

extern(C++) class QSignalBlocker
{
public:
    /+inline+/ explicit QSignalBlocker(QObject *o);
    /+inline+/ explicit QSignalBlocker(QObject &o);
    /+inline+/ ~QSignalBlocker();

#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QSignalBlocker(QSignalBlocker &&other);
    /+inline+/ QSignalBlocker &operator=(QSignalBlocker &&other);
#endif

    /+inline+/ void reblock();
    /+inline+/ void unblock();
private:
    mixin Q_DISABLE_COPY;
    QObject * m_o;
    bool m_blocked;
    bool m_inhibited;
}

QSignalBlocker::QSignalBlocker(QObject *o)
    : m_o(o),
      m_blocked(o && o->blockSignals(true)),
      m_inhibited(false)
{}

QSignalBlocker::QSignalBlocker(QObject &o)
    : m_o(&o),
      m_blocked(o.blockSignals(true)),
      m_inhibited(false)
{}

#ifdef Q_COMPILER_RVALUE_REFS
QSignalBlocker::QSignalBlocker(QSignalBlocker &&other)
    : m_o(other.m_o),
      m_blocked(other.m_blocked),
      m_inhibited(other.m_inhibited)
{
    other.m_o = 0;
}

QSignalBlocker &QSignalBlocker::operator=(QSignalBlocker &&other)
{
    if (this != &other) {
        // if both *this and other block the same object's signals:
        // unblock *this iff our dtor would unblock, but other's wouldn't
        if (m_o != other.m_o || (!m_inhibited && other.m_inhibited))
            unblock();
        m_o = other.m_o;
        m_blocked = other.m_blocked;
        m_inhibited = other.m_inhibited;
        // disable other:
        other.m_o = 0;
    }
    return *this;
}
#endif

QSignalBlocker::~QSignalBlocker()
{
    if (m_o && !m_inhibited)
        m_o->blockSignals(m_blocked);
}

void QSignalBlocker::reblock()
{
    if (m_o) m_o->blockSignals(true);
    m_inhibited = false;
}

void QSignalBlocker::unblock()
{
    if (m_o) m_o->blockSignals(m_blocked);
    m_inhibited = true;
}

namespace QtPrivate {
    /+inline+/ QObject & deref_for_methodcall(QObject &o) { return  o; }
    /+inline+/ QObject & deref_for_methodcall(QObject *o) { return *o; }
}
#define Q_SET_OBJECT_NAME(obj) QT_PREPEND_NAMESPACE(QtPrivate)::deref_for_methodcall(obj).setObjectName(QLatin1String(#obj))

}
