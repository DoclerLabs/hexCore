package hex.util;

using Lambda;

/**
 * ...
 * @author Francis Bourre
 */
class LambdaUtil 
{
	public static function partition<A>( it : Iterable<A>, f : A -> Bool ) : Split<Iterable<A>,Iterable<A>>
	{
		return 
		{
			is:		it.filter( f ),
			isNot:	filterNot( it, f )
		};
	}
	
	public static function filterNot<A>( it : Iterable<A>, f : A -> Bool ) 
	{
		var l = new List<A>();
		for( x in it )
			if( !f(x) )
				l.add(x);
		return l;
	}
	
	public static function transformAndPartition<O, T>( a : Iterable<O>, f : O->Transformation<O, T> ) : Split<Iterable<T>,Iterable<O>>
	{
		var o = new List<O>();
		var t = new List<T>();
		
		for ( e in a )
		{
			switch( f( e ) )
			{
				case Transformed( v ):
					t.add( v );
					
				case Original( v ):
					o.add( v );
			}
		}
		
		return { is: t, isNot: o };
	}
}

typedef Split<T,U> =
{
	var is : 	T;
	var isNot : U;
}

enum Transformation<O,T>
{
	Original( value : O );
	Transformed( value : T );
}