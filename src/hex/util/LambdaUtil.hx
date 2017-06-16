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
	
	public static function transformAndPartition<O, T>( collection : Iterable<O>, transform : O->Transformation<O, T> ) : Split<Array<T>,Array<O>>
	{
		return collection.fold( function( e : O, ret : Split<Array<T>,Array<O>> ) 
		{
			switch( transform( e ) )
			{
				case Transformed( v ): 	ret.is.push( v );
				case Original( v ): 	ret.isNot.push( v );
			}
			return ret;
		}, { is: new Array<T>(), isNot: new Array<O>() } );
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