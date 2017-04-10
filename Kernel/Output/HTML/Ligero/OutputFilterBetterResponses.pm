# --
# Kernel/Output/HTML/OutputFilterMediaWiki.pm
# Copyright (C) 2011 - 2015 Complemento - Liberdade e Tecnologia http://www.complemento.net.br
# --
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
package Kernel::Output::HTML::Ligero::OutputFilterBetterResponses;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;
    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}
sub Run {
	my ( $Self, %Param ) = @_;
	
	# get template name
	my $Templatename = $Param{TemplateFile} || '';
	$Kernel::OM->Get('Kernel::System::Log')->Log(
	    Priority => 'error',
	    Message  => "$Templatename"
	);
	return 1 if !$Templatename;

	my %Data = ();
	
	my $Config = $Kernel::OM->Get('Kernel::Config')->Get('BetterResponses');
	
	$Data{ResponseID} = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam(Param => 'ResponseID');
	$Data{DefaultStateID} = $Config->{DefaultStateID}->{$Data{ResponseID}} || '';

	# Mostra widget central com iframe da pagina
	my $iFrame = $Kernel::OM->Get('Kernel::Output::HTML::Layout')->Output(
    		TemplateFile => 'BetterResponses',
	        Data         => \%Data,
	);
	${ $Param{Data} } .= $iFrame ;

}
1;
