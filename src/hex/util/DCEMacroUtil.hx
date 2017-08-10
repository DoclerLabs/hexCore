package hex.util;

/**
 * Util class to improve Keeping support
 **/
class DCEMacroUtil {
	#if macro
    /**
     * keeping implementations of an interface
     * Add @:keepSub meta on class applying interface
     * Usage in hxml :
     * <pre>--macro addGlobalMetadata('hex.di.IInjectorContainer', "@:autoBuild(hex.util.DCEMacroUtil.keepInterfaceImplementations())", false, true, true)</pre>
     * related issue https://github.com/HaxeFoundation/haxe/issues/6501
    **/
    static function keepInterfaceImplementations() {
        var cl = haxe.macro.Context.getLocalClass().get();
        cl.meta.add(':keepSub', [], cl.pos);
        return null;
    }

    /**
     * Copy metadata in from generic class to concrete class
     * Usage in hxml :
     * <pre>--macro hex.util.DCEMacroUtil.transplantMetaToGenericInstances()</pre>
     * related issue https://github.com/HaxeFoundation/haxe/issues/6500
    **/
    macro static public function transplantMetaToGenericInstances() {
        haxe.macro.Context.onGenerate(function (types) {
            var marker = ':already transplanted';
            for (t in types)
                switch t {
                    case TInst(_.get() => { meta: meta, kind: KGenericInstance(_.get() => original, _) }, _) if (!meta.has(marker)):
                        meta.add(marker, [], original.pos);
                        for (m in original.meta.get())
                            meta.add(m.name, m.params, m.pos);
                    default:
                }
        });
        return macro null;
    }
    #end
}